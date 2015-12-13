#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright (C) 2014, 2015 Bloomberg Finance L.P.
#
require 'poise'

module ConsulCookbook
  module Resource
    # @since 1.0.0
    class ConsulAcl < Chef::Resource
      include Poise(fused: true)
      provides(:consul_acl)
      default_action(:create)

      # @!attribute url
      # @return [String]
      attribute(:url, kind_of: String, default: 'http://localhost:8500')

      # @!attribute auth_token
      # @return [String]
      attribute(:auth_token, kind_of: String, required: true)

      # @!attribute id
      # @return [String]
      attribute(:id, kind_of: String, name_attribute: true)

      # @!attribute acl_name
      # @return [String]
      attribute(:acl_name, kind_of: String, default: '')

      # @!attribute type
      # @return [String]
      attribute(:type, equal_to: %w{client management}, default: 'client')

      # @!attribute rules
      # @return [String]
      attribute(:rules, kind_of: String, default: '')

      def configure_diplomat
        begin
          require 'diplomat'
        rescue LoadError
          fail 'The diplomat gem is required for the consul_acl resource; ' \
               'include recipe[consul::client_gem] to install.'
        end
        Diplomat.configure do |config|
          config.url = url
          config.acl_token = auth_token
          config.options = { request: {timeout: 10 } }
        end
      end

      def acl_definition
        acl = {}
        acl['ID'] = id
        acl['Type'] = type
        acl['Name'] = acl_name
        acl['Rules'] = rules
        acl
      end

      def up_to_date?
        old_acl = Diplomat::Acl.info(acl_definition['ID']).first
        return false if old_acl.nil?
        old_acl.select! { |k, _v| %w(ID Type Name Rules).include?(k) }
        old_acl == acl_definition
      end

      action(:create) do
        new_resource.configure_diplomat
        unless new_resource.up_to_date?
          Diplomat::Acl.create(new_resource.acl_definition)
          new_resource.updated_by_last_action(true)
        end
      end

      action(:delete) do
        new_resource.configure_diplomat
        unless Diplomat::Acl.info(new_resource.id).empty?
          Diplomat::Acl.destroy(new_resource.id)
          new_resource.updated_by_last_action(true)
        end
      end
    end
  end
end
