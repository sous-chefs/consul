#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise'

module ConsulCookbook
  module Resource
    # Resource for managing  Consul ACL roles.
    class ConsulRole < Chef::Resource
      include Poise
      provides(:consul_role)
      actions(:create, :delete)
      default_action(:create)

      # @!attribute url
      # @return [String]
      attribute(:url, kind_of: String, default: 'http://localhost:8500')

      # @!attribute auth_token
      # @return [String]
      attribute(:auth_token, kind_of: String, required: true)

      # @!attribute role_name
      # @return [String]
      attribute(:role_name, kind_of: String, name_attribute: true)

      # @!attribute description
      # @return [String]
      attribute(:description, kind_of: String, default: '')

      # @!attribute policies
      # @return [Array]
      attribute(:policies, kind_of: Array, default: [])

      # @!attribute service_identities
      # @return [Array]
      attribute(:service_identities, kind_of: Array, default: [])

      # @!attribute ssl
      # @return [Hash]
      attribute(:ssl, kind_of: Hash, default: {})

      def to_acl
        { 'Name' => role_name,
          'Description' => description,
          'Policies' => policies,
          'ServiceIdentities' => service_identities }
      end
    end
  end

  module Provider
    # Provider for managing Consul ACL policies.
    class ConsulPolicy < Chef::Provider
      include Poise
      provides(:consul_policy)

      def action_create
        configure_diplomat
        unless up_to_date?
          role = Diplomat::Role.list.select { |p| p['Name'] == new_resource.role_name }
          if role.empty?
            converge_by %|creating ACL role "#{new_resource.role_name}"| do
              Diplomat::Role.create(new_resource.to_acl)
            end
          else
            converge_by %|updating ACL role "#{new_resource.role_name}"| do
              Diplomat::Role.update(new_resource.to_acl.merge('ID' => role.first['ID']))
            end
          end
        end
      end

      def action_delete
        configure_diplomat
        converge_by %|deleting ACL role "#{new_resource.role_name}"| do
          role = Diplomat::Role.list.select { |p| p['Name'] == new_resource.role_name }
          Diplomat::Role.delete(role['ID']) unless role.empty?
        end
      end

      protected

      def configure_diplomat
        begin
          require 'diplomat'
        rescue LoadError
          raise 'The diplomat gem is required; ' \
                'include recipe[consul::client_gem] to install.'
        end
        Diplomat.configure do |config|
          config.url = new_resource.url
          config.acl_token = new_resource.auth_token
          config.options = { ssl: new_resource.ssl, request: { timeout: 10 } }
        end
      end

      def up_to_date?
        retry_block(max_tries: 3, sleep: 0.5) do
          old_role = Diplomat::Role.list.select { |p| p['Name'] == new_resource.role_name }.first
          return false if old_role.nil?
          old_role.select! { |k, _v| %w[Name Description Policies ServiceIdentities].include?(k) }
          old_role == new_resource.to_acl
        end
      end

      def retry_block(opts = {}, &_block)
        opts = {
          max_tries: 3, # Number of tries
          sleep:     0, # Seconds to sleep between tries
        }.merge(opts)

        try_count = 1

        begin
          return yield try_count
        rescue Diplomat::UnknownStatus
          try_count += 1

          # If we've maxed out our attempts, raise the exception to the calling code
          raise if try_count > opts[:max_tries]

          # Sleep before the next retry if the option was given
          sleep opts[:sleep]

          retry
        end
      end
    end
  end
end
