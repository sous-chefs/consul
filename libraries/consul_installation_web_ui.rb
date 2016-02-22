#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise'

module ConsulCookbook
  module Resource
    # A `consul_installation` resource which manages the Consul Web UI
    # installation from an binary.
    # @action create
    # @action remove
    # @provides consul_installation_web_ui
    # @since 1.5
    class ConsulInstallationWebUi < Chef::Resource
      include Poise(fused: true)
      include Helpers::InstallationWebUi
      provides(:consul_installation_web_ui)

      # @!attribute version
      # @return [String]
      attribute(:version, kind_of: String, default: lazy { default_version })
      # @!attribute binary_url
      # @return [String]
      attribute(:binary_url, kind_of: String, required: true)
      # @!attribute binary_path
      # @return [String, NilClass]
      attribute(:binary_path, kind_of: [String, NilClass], default: nil)
      # @!attribute binary_checksum
      # @return [String]
      attribute(:binary_checksum, kind_of: String, lazy { default_checksum })

      action(:create) do
        notifying_block do
          basename = ::File.basename(new_resource.url)
          remote_file ::File.join(Chef::Config[:file_cache_path], basename) do
            not_if { new_resource.binary_path }
          end

          artifact = libartifact_file "consul-webui-#{new_resource.version}" do
            artifact_name 'consul-webui'
            artifact_version new_resource.version
            install_path new_resource.target_path
            remote_url binary_url
            remote_checksum new_resource.binary_checksum
          end
        end
      end

      action(:remove) do
        notifying_block do
          artifact = libartifact_file "consul-webui-#{new_resource.version}" do
            artifact_name 'consul-webui'
            artifact_version new_resource.version
            install_path new_resource.target_path
            remote_url binary_url
            remote_checksum new_resource.binary_checksum
            action :delete
          end
        end
      end
    end
  end
end
