#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright:: 2014-2016, Bloomberg Finance L.P.
#

chef_gem node[cookbook_name]['diplomat_gem'] do
  version node['consul']['diplomat_version'] if node['consul']['diplomat_version']
  compile_time true
end
