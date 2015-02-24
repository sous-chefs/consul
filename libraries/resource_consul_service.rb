#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

class Chef::Resource::ConsulService < Chef::Resource::LWRPBase
  include ConsulCookbook::Helpers

  self.resource_name = :consul_service
  actions :create, :delete, :start, :stop, :restart, :reload
  default_action :start

  attribute :instance, kind_of: String, name_attribute: true, required: true
  attribute :run_user, kind_of: String, default: nil
  attribute :run_group, kind_of: String, default: nil

  attribute :config_filename, kind_of: String, required: true, default: nil
  attribute :config_dir, kind_of: String, required: true, default: nil
  attribute :extra_options, kind_of: Array, default: []
end
