#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
poise_service_user node['consul']['service_user'] do
  group node['consul']['service_group']
  shell node['consul']['service_shell'] unless node['consul']['service_shell'].nil?
  not_if { node.platform_family?('windows') }
  not_if { node['consul']['service_user'] == 'root' }
  not_if { node['consul']['create_service_user'] == false }
end

service_name = node['consul']['service_name']
config = consul_config service_name do |r|
  node['consul']['config'].each_pair { |k, v| r.send(k, v) }
  notifies :reload, "consul_service[#{service_name}]", :delayed
end

install = consul_installation node['consul']['version'] do |r|
  if node['consul']['installation']
    node['consul']['installation'].each_pair { |k, v| r.send(k, v) }
  end
end

consul_service service_name do |r|
  config_file config.path
  program install.consul_program

  if node.platform_family?('windows')
    acl_token node['consul']['config']['acl_master_token']
  else
    user node['consul']['service_user']
    group node['consul']['service_group']
  end
  if node['consul']['service']
    node['consul']['service'].each_pair { |k, v| r.send(k, v) }
  end
end
