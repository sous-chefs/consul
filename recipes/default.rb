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

consul_config node['consul']['service']['config_file'] do |resource|
  user node['consul']['service_user']
  group node['consul']['service_group']

  node['consul']['config'].each_pair { |k, v| resource.send(k, v) }
  notifies :restart, "consul_service[#{node['consul']['service_name']}]", :delayed
end

consul_service node['consul']['service_name'] do
  user node['consul']['service_user']
  group node['consul']['service_group']
  version node['consul']['version']
  install_method node['consul']['service']['install_method']
  install_path node['consul']['service']['install_path']
  config_dir node['consul']['service']['config_dir']
  config_file node['consul']['service']['config_file']

  package_name node['consul']['package_name']
  binary_url node['consul']['binary_url']
  source_url node['consul']['source_url']
end
