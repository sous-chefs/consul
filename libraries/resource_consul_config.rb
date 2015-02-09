#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

class Chef::Resource::ConsulConfig < Chef::Resource::LWRPBase
  self.resource_name = :consul_config
  actions :create, :delete
  default_action :create

  attribute :path, kind_of: String, required: true, name_attribute: true
  attribute :user, kind_of: String, required: true
  attribute :group, kind_of: String, required: true
end
