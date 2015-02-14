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

  attribute :instance, type: String, name_attribute: true, required: true
  attribute :run_user, type: String, default: nil
  attribute :run_group, type: String, default: nil

  attribute :config_filename, type: String, required: true, default: nil
  attribute :config_dir, type: String, required: true, default: nil
  attribute :extra_options, type: Array, default: []
end
