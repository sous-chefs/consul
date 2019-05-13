#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise'

module ConsulCookbook
  module Resource
    # Resource for managing Consul ACL tokens.
    class ConsulToken < Chef::Resource
      include Poise
      provides(:consul_token)
      actions(:create, :delete)
      default_action(:create)

      # @!attribute url
      # @return [String]
      attribute(:url, kind_of: String, default: 'http://localhost:8500')

      # @!attribute auth_token
      # @return [String]
      attribute(:auth_token, kind_of: String, required: true)

      # @!attribute secret_id
      # @return [String]
      attribute(:secret_id, kind_of: String, default: nil)

      # @!attribute description
      # @return [String]
      attribute(:description, kind_of: String, name_attribute: true)

      # @!attribute policies
      # @return [Array]
      attribute(:policies, kind_of: Array, default: [])

      # @!attribute roles
      # @return [Array]
      attribute(:roles, kind_of: Array, default: [])

      # @!attribute service_identities
      # @return [Array]
      attribute(:service_identities, kind_of: Array, default: [])

      # @!attribute expiration_time
      # @return [String]
      attribute(:expiration_time, kind_of: String, default: '')

      # @!attribute expiration_ttl
      # @return [String]
      attribute(:expiration_ttl, kind_of: String, default: nil)

      # @!attribute local
      # @return [Bool]
      attribute(:local, kind_of: [TrueClass, FalseClass], default: false)

      # @!attribute ssl
      # @return [Hash]
      attribute(:ssl, kind_of: Hash, default: {})

      def to_acl
        { 'SecretID' => secret_id,
          'Description' => description.downcase,
          'Local' => local,
          'Policies' => [ policies.each_with_object({}) { |k, h| h['Name'] = k } ],
        }
      end
    end
  end

  module Provider
    # Provider for managing Consul ACL tokens.
    class ConsulToken < Chef::Provider
      include Poise
      provides(:consul_token)

      def action_create
        configure_diplomat
        unless up_to_date?
          old_token = Diplomat::Token.list.select { |p| p['Description'].downcase == new_resource.description.downcase }
          if old_token.empty?
            converge_by %|creating ACL token "#{new_resource.description.downcase}"| do
              Diplomat::Token.create(new_resource.to_acl)
            end
          else
            converge_by %|updating ACL token "#{new_resource.description.downcase}"| do
              Diplomat::Token.update(new_resource.to_acl.merge('AccessorID' => old_token.first['AccessorID']))
            end
          end
        end
      end

      def action_delete
        configure_diplomat
        converge_by %|deleting ACL token "#{new_resource.description.downcase}"| do
          token = Diplomat::Token.list.select { |p| p['Description'].downcase == new_resource.description.downcase }
          Diplomat::Token.delete(token['AccessorID']) unless token.empty?
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
          old_token_id = Diplomat::Token.list.select { |p| p['Description'].downcase == new_resource.description.downcase }
          if old_token_id.empty?
            Chef::Log.warn %|Token with description "#{new_resource.description.downcase}" was not found. Will create.|
            return false
          end
          old_token = Diplomat::Token.read(old_token_id.first['AccessorID'], {}, :return)
          old_token.select! { |k, _v| %w(SecretID Description Policies Local).include?(k) }
          old_token['Description'].downcase!
          old_token == new_resource.to_acl
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
