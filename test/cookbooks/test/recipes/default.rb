# frozen_string_literal: true

consul_installation 'default' do
  version node['consul_test']['version']
  install_method node['consul_test']['install_method']
end

group 'consul' do
  system true
end

user 'consul' do
  system true
  group 'consul'
  shell '/bin/false'
end

config = consul_config node['consul_test']['config_path'] do
  owner 'root'
  group 'consul'
  server true
  bootstrap true
  datacenter 'FortMeade'
  encrypt 'CGXC2NsXW4AvuB4h5ODYzQ=='
  acl({ 'enabled' => true, 'default_policy' => 'deny', 'tokens' => { 'initial_management' => 'doublesecret' } })
  ui_config({ 'enabled' => true })
  notifies :reload, 'consul_service[consul]', :delayed
end

consul_service 'consul' do
  config_file config.path
  user 'consul'
  group 'consul'
  systemd_params('LimitNOFILE' => 9001)
  action [:enable, :start]
end
