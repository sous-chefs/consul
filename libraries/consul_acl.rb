#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise'

module ConsulCookbook
  module Resource
    # Resource for managing  Consul ACLs.
    class ConsulAcl < Chef::Resource
      include Poise
      provides(:consul_acl)
      actions(:create, :delete)
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

      def to_acl
        { 'ID' => id, 'Type' => type, 'Name' => acl_name, 'Rules' => rules }
      end
    end
  end

  module Provider
    # Provider for managing  Consul ACLs.
    class ConsulAcl < Chef::Provider
      include Poise
      provides(:consul_acl)

      def action_create
        configure_diplomat
        unless up_to_date?
          Diplomat::Acl.create(new_resource.to_acl)
          new_resource.updated_by_last_action(true)
        end
      end

      def action_delete
        configure_diplomat
        unless Diplomat::Acl.info(new_resource.id).empty?
          Diplomat::Acl.destroy(new_resource.id)
          new_resource.updated_by_last_action(true)
        end
      end

      protected

      def configure_diplomat
        begin
          require 'diplomat'
        rescue LoadError
          raise RunTimeError, 'The diplomat gem is required; ' \
                              'include recipe[consul::client_gem] to install.'
        end
        Diplomat.configure do |config|
          config.url = new_resource.url
          config.acl_token = new_resource.auth_token
          config.options = { request: { timeout: 10 } }
        end
      end

      def up_to_date?
        old_acl = Diplomat::Acl.info(new_resource.to_acl['ID'], nil, :return)
        return false if old_acl.nil? || old_acl.empty?
        old_acl.first.select! { |k, _v| %w(ID Type Name Rules).include?(k) }
        old_acl.first == new_resource.to_acl
      end
    end
  end
end
