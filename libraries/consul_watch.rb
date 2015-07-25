#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright (C) 2014, 2015 Bloomberg Finance L.P.
#
require 'poise'

class Chef::Resource::ConsulWatch < Chef::Resource
  include Poise(fused: true)
  provides(:consul_watch)
  actions(:create, :delete)

  # @!attribute watch_name
  # @return [String]
  attribute(:watch_name, kind_of: String, name_attribute: true)

  # @!attribute watch_type
  # @return [String]
  attribute(:watch_type, equal_to: %w(checks event key keyprefix service))

  # @!attribute datacenter
  # @return [String]
  attribute(:datacenter, kind_of: String)

  # @!attribute handler
  # @return [String]
  attribute(:handler, kind_of: String)

  # @!attribute token
  # @return [String]
  attribute(:token, kind_of: String)

  action(:create) do
    execute new_resource.command do
      guard_interpreter :default
    end
  end

  action(:delete) do
  end
end
