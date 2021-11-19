#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright:: 2014-2016, Bloomberg Finance L.P.
#

group node['consul']['service_group'] do
  system true
  not_if { platform?('windows') }
  not_if { node['consul']['service_group'] == 'root' }
  not_if { node['consul']['create_service_user'] == false }
end

user node['consul']['service_user'] do
  system true
  group node['consul']['service_group']
  shell node['consul']['service_shell']
  not_if { platform?('windows') }
  not_if { node['consul']['service_user'] == 'root' }
  not_if { node['consul']['create_service_user'] == false }
end

service_name = node['consul']['service_name']
config = consul_config service_name do
  node['consul']['config'].each_pair { |k, v| send(k.to_sym, v) }
  notifies :reload, "consul_service[#{service_name}]", :delayed
end

install = consul_installation node['consul']['version'] do
  if node['consul']['installation']
    node['consul']['installation'].each_pair { |k, v| send(k.to_sym, v) }
  end
end

consul_service service_name do
  config_file config.path
  program install.consul_program

  if platform?('windows')
    acl_token node['consul']['config']['acl_master_token']
  else
    user node['consul']['service_user']
    group node['consul']['service_group']
  end
  if node['consul']['service']
    node['consul']['service'].each_pair { |k, v| send(k.to_sym, v) }
  end
end
