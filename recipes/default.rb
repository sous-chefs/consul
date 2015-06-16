#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#
include_recipe 'selinux::permissive'

poise_service_user node['consul']['service_user'] do
  group node['consul']['service_group']
end

consul_config node['consul']['service']['config_file'] do |r|
  user node['consul']['service_user']
  group node['consul']['service_group']

  node['consul']['config'].each_pair { |k, v| r.send(k, v) }
  notifies :restart, "consul_service[#{node['consul']['service_name']}]", :delayed
end

consul_service node['consul']['service_name'] do |r|
  user node['consul']['service_user']
  group node['consul']['service_group']
  version node['consul']['version']

  node['consul']['service'].each_pair { |k, v| r.send(k, v) }
  action [:enable, :start]
end
