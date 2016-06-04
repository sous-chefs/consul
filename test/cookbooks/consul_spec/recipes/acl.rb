include_recipe 'consul_spec::default'
include_recipe 'consul::client_gem'

package 'curl'

consul_acl 'anonymous' do
  acl_name 'Anonymous Token'
  type 'client'
  url "http://localhost:#{node['consul']['config']['ports']['http']}"
  auth_token node['consul']['config']['acl_master_token']
  notifies :create, 'file[/tmp/anonymous-notified]', :immediately
end

file '/tmp/anonymous-notified' do
  action :nothing
end

consul_acl 'management_token' do
  acl_name 'Management Token'
  type 'management'
  auth_token node['consul']['config']['acl_master_token']
  notifies :create, 'file[/tmp/management_token-notified]', :immediately
end

file '/tmp/management_token-notified' do
  action :nothing
end

consul_acl 'delete_management_token' do
  id 'management_token'
  auth_token node['consul']['config']['acl_master_token']
  action :delete
end

consul_acl 'non_existing_token' do
  auth_token node['consul']['config']['acl_master_token']
  action :delete
end

consul_acl 'reader_token' do
  type 'client'
  rules <<-EOS.gsub(/^\s{4}/, '')
    dummyrule_line1
    dummyrule_line2
  EOS
  auth_token node['consul']['config']['acl_master_token']
end


