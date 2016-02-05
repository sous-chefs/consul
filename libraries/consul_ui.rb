#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise'
require_relative 'helpers'

module ConsulCookbook
  module Resource
    # Resource for managing the Consul web UI installation.
    class ConsulUI < Chef::Resource
      include Poise
      include ConsulCookbook::Helpers
      provides(:consul_ui)
      default_action(:install)

      # @!attribute version
      # @return [String]
      attribute(:version, kind_of: String, required: true)

      # @!attribute install_path
      # @return [String]
      attribute(:install_path, kind_of: String, default: '/srv')

      # @!attribute owner
      # @return [String]
      attribute(:owner, kind_of: String, default: 'consul')

      # @!attribute group
      # @return [String]
      attribute(:group, kind_of: String, default: 'consul')

      # @!attribute binary_url
      # @return [String]
      attribute(:binary_url, kind_of: String, default: 'https://releases.hashicorp.com/consul/%{version}/%{filename}.zip')

      # @!attribute source_url
      # @return [String]
      attribute(:source_url, kind_of: String)
    end
  end

  module Provider
    # Provider for managing the Consul web UI installation.
    class ConsulUI < Chef::Provider
      include Poise
      provides(:consul_ui)

      def action_install
        notifying_block do
          libartifact_file "#{new_resource.name}-#{new_resource.version}" do
            artifact_name new_resource.name
            artifact_version new_resource.version
            owner new_resource.owner
            group new_resource.group
            install_path new_resource.install_path
            remote_url new_resource.binary_url % { version: new_resource.version, filename: new_resource.binary_filename('web_ui') }
            remote_checksum new_resource.binary_checksum 'web_ui'
          end
        end
      end

      def action_uninstall
        notifying_block do
          libartifact_file "#{new_resource.name}-#{new_resource.version}" do
            action :delete
            artifact_name new_resource.name
            artifact_version new_resource.version
            install_path new_resource.install_path
          end
        end
      end
    end
  end
end
