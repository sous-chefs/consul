#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

directory ::File.join(node['consul']['service']['install_path'], 'consul_web_ui') do
  owner node['consul']['service_user']
  group node['consul']['service_group']
  mode '0755'
  recursive true
  action node['consul']['ui']['enabled'] ? :create : :delete
end

ark 'web_ui' do
  url node['consul']['ui']['url'] % { version: node['consul']['ui']['version'] }
  version node['consul']['ui']['version']
  path ::File.join(node['consul']['service']['install_path'], 'consul_web_ui')
  append_env_path false
  strip_components 1
  action node['consul']['ui']['enabled'] ? :put : :nothing
end
