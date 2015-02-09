#
# Cookbook Name:: consul
# Recipe:: default
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#
user node['consul']['service_user'] do
  system true
  home '/dev/null'
  shell '/bin/false'
  not_if { username == 'root' }
end

group node['consul']['service_group'] do
  system true
  members node['consul']['service_user']
  not_if { group_name == 'root' }
end

consul_config node['consul']['config_dir'] do
  user node['consul']['service_user']
  group node['consul']['service_group']
end

consul_client Chef::Consul.install_path(node) do
  filename Chef::Consul.remote_filename(node)
  url Chef::Consul.remote_url(node)
  checksum Chef::Consul.remote_checksum(node)
  version node['consul']['version']
  user node['consul']['service_user']
  group node['consul']['service_group']
end

consul_service 'consul' do
  action :start
end
