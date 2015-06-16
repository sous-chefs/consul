#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#
node.default['poise-service']['provider'] = 'runit'
include_recipe 'runit::default'
include_recipe 'consul::default'
