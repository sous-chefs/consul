#
# Copyright 2014 John Bellone <jbellone@bloomberg.net>
# Copyright 2014 Bloomberg Finance L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'json'

# Configure directories
consul_directories = []
consul_directories << node['consul']['data_dir']
consul_directories << node['consul']['config_dir']

case node['consul']['init_style']
when 'runit'
  include_recipe 'runit::default'
  consul_directories << '/var/log/consul'
when 'windows'
  # already added, move along
else
  consul_directories << '/var/lib/consul'
end


# Select service user & group
consul_user  = node['consul']['service_user']
consul_group = node['consul']['service_group']

# Create service user
case node['consul']['init_style']
when 'windows'
  user "consul service user: #{consul_user}" do
    not_if { consul_user == 'Administrator' }
    username consul_user
    comment 'consul service user'
  end
else
  user "consul service user: #{consul_user}" do
    not_if { consul_user == 'root' }
    username consul_user
    home '/dev/null'
    shell '/bin/false'
    system node['consul']['system_account']
    comment 'consul service user'
  end
end

# Create service group
group "consul service group: #{consul_group}" do
  not_if { consul_group == 'root' && node['platform'] != 'windows'}
  not_if { consul_group == 'Administrators' && node['platform'] == 'windows'}
  group_name consul_group
  members consul_user
  system node['consul']['system_account']
  append true
end

# Create service directories
consul_directories.uniq.each do |dirname|
  directory dirname do
    if node['platform'] == 'windows'
      rights :full_control, node['consul']['service_user'], :applies_to_children => true
      recursive true
    else
      user consul_user
      group consul_group
    end
    mode 0755
  end

  execute "chown -R #{consul_user}:#{consul_group} #{dirname}" do
    not_if { node['platform'] == 'windows' }
    only_if do
      Etc.getpwuid(File.stat(dirname).uid).name != consul_user or
        Etc.getgrgid(File.stat(dirname).gid).name != consul_group
    end
  end
end

# Determine service params
service_config = JSON.parse(node['consul']['extra_params'].to_json)
service_config['data_dir'] = node['consul']['data_dir']
num_cluster = node['consul']['bootstrap_expect'].to_i
join_mode = node['consul']['retry_on_join'] ? 'retry_join' : 'start_join'

case node['consul']['service_mode']
when 'bootstrap'
  service_config['server'] = true
  service_config['bootstrap'] = true
when 'cluster'
  service_config['server'] = true
  if num_cluster > 1
    service_config['bootstrap_expect'] = num_cluster
    service_config[join_mode] = node['consul']['servers']
  else
    service_config['bootstrap'] = true
  end
when 'server'
  service_config['server'] = true
  service_config[join_mode] = node['consul']['servers']
when 'client'
  service_config[join_mode] = node['consul']['servers']
else
  Chef::Application.fatal! %Q(node['consul']['service_mode'] must be "bootstrap", "cluster", "server", or "client")
end

iface_addr_map = {
  bind_interface: :bind_addr,
  advertise_interface: :advertise_addr,
  client_interface: :client_addr
}

iface_addr_map.each_pair do |interface,addr|
  next unless node['consul'][interface]

  if node["network"]["interfaces"][node['consul'][interface]]
    ip = node["network"]["interfaces"][node['consul'][interface]]["addresses"].detect{|k,v| v[:family] == "inet"}.first
    node.default['consul'][addr] = ip
  else
    Chef::Application.fatal!("Interface specified in node['consul'][#{interface}] does not exist!")
  end
end

if node['consul']['serve_ui']
  service_config['ui_dir']      = Chef::ConsulUI.active_path(node)
  service_config['client_addr'] = node['consul']['client_addr']
end

additional_options = ['recursor', 'statsd_addr', 'leave_on_terminate', 'rejoin_after_leave', 'disable_remote_exec', 'acl_datacenter', 'acl_token', 'acl_default_policy', 'acl_down_policy', 'acl_master_token']

additional_options.each do |option|
  if node['consul'][option]
    service_config[option] = node['consul'][option]
  end
end

copy_params = [
  :bind_addr, :datacenter, :domain, :log_level, :node_name, :advertise_addr, :ports, :enable_syslog, :statsd_addr
]
copy_params.each do |key|
  if node['consul'][key]
    if key == :ports
      Chef::Application.fatal! 'node[:consul][:ports] must be a Hash' unless node[:consul][key].kind_of?(Hash)
    end

    service_config[key] = node['consul'][key]
  end
end

dbi = nil
# Gossip encryption
if node.consul.encrypt_enabled
  # Fetch the databag only once, and use empty hash if it doesn't exists
  dbi = consul_encrypted_dbi || {}
  secret = consul_dbi_key_with_node_default(dbi, 'encrypt')
  raise "Consul encrypt key is empty or nil" if secret.nil? or secret.empty?
  service_config['encrypt'] = secret
else
  # for backward compatibilty
  service_config['encrypt'] = node.consul.encrypt unless node.consul.encrypt.nil?
end

# TLS encryption
if node.consul.verify_incoming || node.consul.verify_outgoing
  dbi = consul_encrypted_dbi || {} if dbi.nil?
  service_config['verify_outgoing'] = node.consul.verify_outgoing
  service_config['verify_incoming'] = node.consul.verify_incoming

  ca_path = node.consul.ca_path % { config_dir: node.consul.config_dir }
  service_config['ca_file'] = ca_path

  cert_path = node.consul.cert_path % { config_dir: node.consul.config_dir }
  service_config['cert_file'] = cert_path

  key_path = node.consul.key_file_path % { config_dir: node.consul.config_dir }
  service_config['key_file'] = key_path

  # Search for key_file_hostname since key and cert file can be unique/host
  key_content = dbi['key_file_' + node.fqdn] || consul_dbi_key_with_node_default(dbi, 'key_file')
  cert_content = dbi['cert_file_' + node.fqdn] || consul_dbi_key_with_node_default(dbi, 'cert_file')
  ca_content = consul_dbi_key_with_node_default(dbi, 'ca_cert')

  # Save the certs if exists
  {ca_path => ca_content, key_path => key_content, cert_path => cert_content}.each do |path, content|
    unless content.nil? or content.empty?
      file path do
        user consul_user
        group consul_group
        mode 0600
        action :create
        content content
      end
    end
  end
end

# Atlas integration
if node['consul']['atlas_autojoin'] or node['consul']['atlas_token']
  cluster = node['consul']['atlas_cluster']
  token = node['consul']['atlas_token']
  raise "atlas_cluster is empty or nil" if cluster.empty? or cluster.nil?
  raise "atlas_token is empty or nil" if token.empty? or token.nil?
  service_config['atlas_infrastructure'] = cluster
  service_config['atlas_join'] = node['consul']['atlas_autojoin']
  service_config['atlas_token'] = token
end

consul_config_filename = File.join(node['consul']['config_dir'], 'default.json')

file consul_config_filename do
  user consul_user
  group consul_group
  mode 0600
  action :create
  content JSON.pretty_generate(service_config, quirks_mode: true)
  # https://github.com/johnbellone/consul-cookbook/issues/72
  notifies :restart, "service[consul]"
end

case node['consul']['init_style']
when 'init'
  if platform?("ubuntu")
    init_file = '/etc/init/consul.conf'
    init_tmpl = 'consul.conf.erb'
    init_mode = 0644
  else
    init_file = '/etc/init.d/consul'
    init_tmpl = 'consul-init.erb'
    init_mode = 0755
  end

  template node['consul']['etc_config_dir'] do
    source 'consul-sysconfig.erb'
    mode 0644
    notifies :create, "template[#{init_file}]", :immediately
  end

  template init_file do
    source init_tmpl
    mode init_mode
    variables(
      consul_logfile: node['consul']['logfile'],
      startup_sleep: node['consul']['startup_sleep'],
      soft_limit: node['consul']['files_soft_limit'],
      hard_limit: node['consul']['files_hard_limit']
    )
    notifies :restart, 'service[consul]', :immediately
  end

  service 'consul' do
    provider Chef::Provider::Service::Upstart if platform?("ubuntu")
    supports status: true, restart: true, reload: true
    action [:enable, :start]
    subscribes :restart, "file[#{consul_config_filename}]"
    subscribes :restart, "link[#{Chef::Consul.active_binary(node)}]"
  end
when 'runit'
  runit_service 'consul' do
    supports status: true, restart: true, reload: true
    action [:enable, :start]
    subscribes :restart, "file[#{consul_config_filename}]"
    subscribes :restart, "link[#{Chef::Consul.active_binary(node)}]"
    log true
  end

  service 'consul' do
    supports status: true, restart: true, reload: true
    reload_command "'#{node['runit']['sv_bin']}' hup consul"
  end
when 'systemd'
  template node['consul']['etc_config_dir'] do
    source 'consul-sysconfig.erb'
    mode 0644
    notifies :create, "template[/etc/systemd/system/consul.service]", :immediately
  end

  template '/etc/systemd/system/consul.service' do
    source 'consul-systemd.erb'
    mode 0644
    notifies :restart, 'service[consul]', :immediately
  end

  service 'consul' do
    supports status: true, restart: true, reload: true
    action [:enable, :start]
    subscribes :restart, "file[#{consul_config_filename}]"
    subscribes :restart, "link[#{Chef::Consul.active_binary(node)}]"
  end
when 'windows'
  # Windows service for consul has been create by Chocolatey and
  # config is managed by the chocolatey package
  service 'consul' do
    subscribes :restart, "file[#{consul_config_filename}]"
  end
end
