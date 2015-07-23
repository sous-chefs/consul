# Cookbook: consul
# License: Apache 2.0
#
# Copyright (C) 2014, 2015 Bloomberg Finance L.P.
#
require 'poise'

module ConsulCookbook
  module Resource
    # @since 1.0.0
    class ConsulACL < Chef::Resource
      include Poise(fused: true)
      provides(:consul_acl)
      default_action(:create)

      # @!attribute name
      # @return [String]
      attribute(:name, name_attribute: true, kind_of: String)
      # @!attribute rules
      # @return [String]
      attribute(:rules, kind_of: String)
      # @!attribute id
      # @return [String]
      attribute(:id, kind_of: String)
      # @!attribute type
      # @return [String]
      attribute(:type, kind_of: String, default: 'client', required: true)

      action :create do
        ruby_block @new_resource.name do
          data = {}
          data['Name'] = new_resource.name
          data['Type'] = new_resource.type
          data['Rules'] = new_resource.rules
          data['ID'] = new_resource.id unless new_resource.id.nil?
          block { client.manage_acl(data) }
          only_if { !current_resource || update_required? }
        end
      end

      action :delete do
        ruby_block new_resource.name do
          block { client.delete_acl(new_resource.name) }
          only_if { current_resource }
        end
      end

      def client
        @client ||= Chef::Consul::Client.new(nil, node['consul']['ports']['http'], node['consul']['acl_master_token'])
      end

      def load_current_resource
        if @new_resource.id
          @current_resource = client.get_acl_by_id(@new_resource.id)
        else
          @current_resource = client.get_acl_by_name(@new_resource.name)
        end
      end

      def update_required?
        current_resource['Rules'] != new_resource.rules || current_resource['Type'] != new_resource.type
      end
    end
  end
end
