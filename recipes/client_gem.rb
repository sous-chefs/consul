#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#

chef_gem 'diplomat' do
  version node['consul']['diplomat_version'] if node['consul']['diplomat_version']
  action :install
end
