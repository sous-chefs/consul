#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

class Chef::Resource::ConsulService < Chef::Resource::LWRPBase
  self.resource_name = :consul_service
  actions :start, :stop, :restart, :enable, :disable, :reload
  default_action :start

  attribute :service_name, type: String, name_attribute: true, required: true
  attribute :etc_config_dir, type: String, required: true
  attribute :config_dir, type: String, required: true
end
