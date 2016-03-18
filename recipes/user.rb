#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#

unless windows?
  group node['consul']['service_group'] do
    system true
  end

  user node['consul']['service_user'] do
    shell '/bin/bash'
    group node['consul']['service_group']
    system true
  end
end
