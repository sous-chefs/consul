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
consul_directories << '/var/lib/consul'

# Select service user & group
case node['consul']['init_style']
when 'runit'
  include_recipe 'runit::default'

  consul_user = node['consul']['service_user']
  consul_group = node['consul']['service_group']
  consul_directories << '/var/log/consul'
else
  consul_user = 'root'
  consul_group = 'root'
end

# Create service user
user "consul service user: #{consul_user}" do
  not_if { consul_user == 'root' }
  username consul_user
  home '/dev/null'
  shell '/bin/false'
  comment 'consul service user'
end

# Create service group
group "consul service group: #{consul_group}" do
  not_if { consul_group == 'root' }
  group_name consul_group
  members consul_user
  append true
end

# Create service directories
consul_directories.each do |dirname|
  directory dirname do
    owner consul_user
    group consul_group
    mode 0755
  end
end

# Determine service params
service_config = {}
service_config['data_dir'] = node['consul']['data_dir']
num_cluster = node['consul']['bootstrap_expect'].to_i

case node['consul']['service_mode']
when 'bootstrap'
  service_config['server'] = true
  service_config['bootstrap'] = true
when 'cluster'
  service_config['server'] = true
  if num_cluster > 1
    service_config['bootstrap_expect'] = num_cluster
    service_config['start_join'] = node['consul']['servers']
  else
    service_config['bootstrap'] = true
  end
when 'server'
  service_config['server'] = true
  service_config['start_join'] = node['consul']['servers']
when 'client'
  service_config['start_join'] = node['consul']['servers']
else
  Chef::Application.fatal! %Q(node['consul']['service_mode'] must be "bootstrap", "cluster", "server", or "client")
end

iface_addr_map = {
  :bind_interface => :bind_addr,
  :advertise_interface => :advertise_addr,
  :client_interface => :client_addr
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
  service_config['ui_dir'] = node['consul']['ui_dir']
  service_config['client_addr'] = node['consul']['client_addr']
end

copy_params = [
  :bind_addr, :datacenter, :domain, :log_level, :node_name, :advertise_addr, :enable_syslog, :encrypt
]
copy_params.each do |key|
  if node['consul'][key]
    service_config[key] = node['consul'][key]
  end
end

consul_config_filename = File.join(node['consul']['config_dir'], 'default.json')

file consul_config_filename do
  user consul_user
  group consul_group
  mode 0600
  action :create
  content JSON.pretty_generate(service_config, quirks_mode: true)
end

case node['consul']['init_style']
when 'init'
  directory "/etc/sysconfig" do
    action :create
    mode "0755"
  end

  template '/etc/sysconfig/consul' do
    source 'consul-sysconfig.erb'
    mode 0755
    notifies :create, 'template[/etc/init.d/consul]', :immediately
  end
  template '/etc/init.d/consul' do
    source 'consul-init.erb'
    mode 0755
    variables(
      consul_binary: "#{node['consul']['install_dir']}/consul",
      config_dir: node['consul']['config_dir'],
    )
    notifies :restart, 'service[consul]', :immediately
  end

  service 'consul' do
    supports status: true, restart: true, reload: true
    action [:enable, :start]
    subscribes :restart, "file[#{consul_config_filename}", :delayed
  end
when 'runit'
  runit_service 'consul' do
    supports status: true, restart: true, reload: true
    action [:enable, :start]
    subscribes :restart, "file[#{consul_config_filename}]", :delayed
    log true
    options(
      consul_binary: "#{node['consul']['install_dir']}/consul",
      config_dir: node['consul']['config_dir'],
    )
  end
end
