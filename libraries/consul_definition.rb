#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright (C) 2014, 2015 Bloomberg Finance L.P.
#
require 'poise'

class Chef::Resource::ConsulDefinition < Chef::Resource
  include Poise(fused: true)
  provides(:consul_definition)
  actions(:create, :delete)

  # @!attribute path
  # @return [String]
  attribute(:path, kind_of: String, name_attribute: true)

  # @!attribute id
  # @return [String, NilClass]
  attribute(:id, kind_of: String)

  # @!attribute user
  # @return [String]
  attribute(:user, kind_of: String, default: 'consul')

  # @!attribute group
  # @return [String]
  attribute(:group, kind_of: String, default: 'consul')

  def to_json
    for_keeps = %i{}
    config = to_hash.keep_if do |k, v|
      for_keeps.include?(k.to_sym)
    end
    JSON.pretty_generate(config, quirks_mode: true)
  end

  action(:create) do
    notifying_block do
      file new_resource.path do
        content new_resource.to_json
        user new_resource.user
        group new_resource.group
        mode '0600'
      end
    end
  end

  action(:delete) do
    notifying_block do
      file new_resource.path do
        action :delete
      end
    end
  end
end
