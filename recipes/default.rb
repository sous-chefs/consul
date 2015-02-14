#
# Cookbook Name:: consul
# Recipe:: default
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

client = consul_client Chef::Consul.install_path(node) do
  filename Chef::Consul.remote_filename(node)
  url Chef::Consul.remote_url(node)
  checksum Chef::Consul.remote_checksum(node)
  version node['consul']['version']
  run_user node['consul']['service_user']
  run_group node['consul']['service_group']
end

config = consul_config File.join(node['consul']['config_dir'], 'default.json') do
  run_user client.run_user
  run_group client.run_group
end

consul_service 'consul' do
  run_user client.run_user
  run_group client.run_group

  action :start
end
