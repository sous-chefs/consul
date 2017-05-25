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
      attribute(:type, equal_to: %w(client management), default: 'client')

      # @!attribute rules
      # @return [String]
      attribute(:rules, kind_of: String, default: '')

      # @!attribute client_cert
      # @return [String]
      attribute(:client_cert, kind_of: String, default: nil)

      # @!attribute client_key
      # @return [String]
      attribute(:client_key, kind_of: String, default: nil)

      # @!attribute ca_file
      # @return [String]
      attribute(:ca_file, kind_of: String, default: nil)

      # @!attribute ca_path
      # @return [String]
      attribute(:ca_path, kind_of: String, default: nil)

      # @!attribute cert_store
      # @return [String]
      attribute(:cert_store, kind_of: String, default: nil)

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
          ssl_options = {}
          ssl_options[:client_cert] = new_resource.client_cert unless new_resource.client_cert.nil?
          ssl_options[:client_key] = new_resource.client_key unless new_resource.client_key.nil?
          ssl_options[:ca_file] = new_resource.ca_file unless new_resource.ca_file.nil?
          ssl_options[:ca_path] = new_resource.ca_path unless new_resource.ca_path.nil?
          ssl_options[:cert_store] = new_resource.cert_store unless new_resource.cert_store.nil?

          if ssl_options.empty?
            config.options = { request: { timeout: 10 } }
          else
            config.options = { ssl: ssl_options, request: { timeout: 10 } }
          end
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
