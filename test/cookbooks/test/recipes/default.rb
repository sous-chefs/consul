#
# Cookbook:: test
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

consul '1.7.2' do
  action :install
end

consul_config 'consul.json' do
  server true
  advertise_addr '127.0.0.1'
end

consul_watch 'consul_watch_check.json' do
  
end
