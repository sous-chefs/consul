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
    class ConsulWatch < Chef::Resource
      include Poise(fused: true)
      include ConsulCookbook::Helpers
      provides(:consul_watch)
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
      attribute(:type, equal_to: %w(checks event key keyprefix nodes service services))

      # @!attribute parameters
      # @return [Hash]
      attribute(:parameters, option_collector: true, default: {})

      def params_to_json
        JSON.pretty_generate(watches: [{ type: type }.merge(parameters)])
      end

      action(:create) do
        notifying_block do
          directory ::File.dirname(new_resource.path) do
            recursive true
            unless platform?('windows')
              owner new_resource.user
              group new_resource.group
              mode '0755'
            end
          end

          file new_resource.path do
            content new_resource.params_to_json
            unless platform?('windows')
              owner new_resource.user
              group new_resource.group
              mode '0640'
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

