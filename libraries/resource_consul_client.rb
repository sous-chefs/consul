#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

class Chef::Resource::ConsulClient < Chef::Resource::LWRPBase
  self.resource_name = :consul_client
  actions :create, :delete
  default_action :create

  attribute :path, kind_of: String, name_attribute: true, required: true
  attribute :run_user, kind_of: String, required: true
  attribute :run_group, kind_of: String, required: true
  attribute :url, kind_of: String, required: true, default: nil
  attribute :version, kind_of: String, required: true, default: nil
  attribute :checksum, kind_of: String, default: nil
end
