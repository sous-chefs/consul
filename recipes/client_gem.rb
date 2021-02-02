#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#

if Chef::Resource::ChefGem.instance_methods(false).include?(:compile_time)
  chef_gem 'diplomat' do
    version node['consul']['diplomat_version'] if node['consul']['diplomat_version']
    compile_time true
  end
else
  chef_gem 'diplomat' do
    version node['consul']['diplomat_version'] if node['consul']['diplomat_version']
    action :nothing
  end.run_action(:install)
end
