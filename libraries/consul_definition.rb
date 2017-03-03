#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise'

module ConsulCookbook
  module Resource
    # @since 1.0.0
    class ConsulDefinition < Chef::Resource
      include Poise(fused: true)
      include ConsulCookbook::Helpers
      provides(:consul_definition)
      default_action(:create)

      # @!attribute path
      # @return [String]
      attribute(:path, kind_of: String, default: lazy { join_path node['consul']['service']['config_dir'], "#{name}.json" })

      # @!attribute user
      # @return [String]
      attribute(:user, kind_of: String, default: lazy { node['consul']['service_user'] })

      # @!attribute group
      # @return [String]
      attribute(:group, kind_of: String, default: lazy { node['consul']['service_group'] })

      # @!attribute type
      # @return [String]
      attribute(:type, equal_to: %w(check service checks services))

      # @!attribute parameters
      # @return [Hash]
      attribute(:parameters, option_collector: true, default: {})

      def to_json
        final_parameters = parameters
        final_parameters = final_parameters.merge(name: name) if final_parameters[:name].nil?
        JSON.pretty_generate(type => final_parameters)
      end

      action(:create) do
        notifying_block do
          directory ::File.dirname(new_resource.path) do
            recursive true
            unless platform?('windows')
              owner new_resource.user
              group new_resource.group
              mode '0755'
              # Prevent clobbering permissions on the directory since the intent
              # in this context is to set the permissions of the definition file
              not_if { Dir.exist? path }
            end
          end

          file new_resource.path do
            content new_resource.to_json
            unless platform?('windows')
              owner new_resource.user
              group new_resource.group
              mode '0644'
            end
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
  end
end
