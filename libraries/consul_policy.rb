#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise'

module ConsulCookbook
  module Resource
    # Resource for managing  Consul ACL policies.
    class ConsulPolicy < Chef::Resource
      include Poise
      provides(:consul_policy)
      actions(:create, :delete)
      default_action(:create)

      # @!attribute url
      # @return [String]
      attribute(:url, kind_of: String, default: 'http://localhost:8500')

      # @!attribute auth_token
      # @return [String]
      attribute(:auth_token, kind_of: String, required: true)

      # @!attribute policy_name
      # @return [String]
      attribute(:policy_name, kind_of: String, name_attribute: true)

      # @!attribute description
      # @return [String]
      attribute(:description, kind_of: String, default: '')

      # @!attribute type
      # @return [Array]
      attribute(:datacenters, kind_of: Array, default: [])

      # @!attribute rules
      # @return [String]
      attribute(:rules, kind_of: String, default: '')

      # @!attribute ssl
      # @return [Hash]
      attribute(:ssl, kind_of: Hash, default: {})

      def to_acl
        { 'Name' => policy_name,
          'Description' => description,
          'Datacenters' => datacenters,
          'Rules' => rules }
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
          policy = Diplomat::Policy.list.select { |p| p['Name'].downcase == new_resource.policy_name.downcase }
          if policy.empty?
            converge_by %|creating ACL policy "#{new_resource.policy_name.downcase}"| do
              Diplomat::Policy.create(new_resource.to_acl)
            end
          else
            converge_by %|updating ACL policy "#{new_resource.policy_name.downcase}"| do
              Diplomat::Policy.update(new_resource.to_acl.merge('ID' => policy.first['ID']))
            end
          end
        end
      end

      def action_delete
        configure_diplomat
        converge_by %|deleting ACL policy "#{new_resource.policy_name.downcase}"| do
          policy = Diplomat::Policy.list.select { |p| p['Name'].downcase == new_resource.policy_name.downcase }
          Diplomat::Policy.delete(policy['ID']) unless policy.empty?
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
          old_policy_id = Diplomat::Policy.list.select { |p| p['Name'].downcase == new_resource.policy_name.downcase }
          return false if old_policy_id.empty?
          old_policy = Diplomat::Policy.read(old_policy_id.first['ID'], {}, :return)
          return false if old_policy.nil?
          old_policy.first.select! { |k, _v| %w[Name Description Rules].include?(k) }
          old_policy['Description'].downcase!
          old_policy.first == new_resource.to_acl
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
