#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright (C) 2014, 2015 Bloomberg Finance L.P.
#
require 'poise_service/service_mixin'

module ConsulCookbook
  module Resource
    # Resource for managing the Consul service on an instance.
    # @since 1.0.0
    class ConsulInstall < Chef::Resource
      include Poise
      provides(:consul_install)
      actions(:install, :uninstall)

      # @!attribute version
      # @return [String]
      attribute(:version, kind_of: String, required: true)

      # @!attribute install_path
      # @return [String]
      attribute(:install_path, kind_of: String, default: '/srv')

      # @!attribute user
      # @return [String]
      attribute(:user, kind_of: String, default: 'consul')

      # @!attribute group
      # @return [String]
      attribute(:group, kind_of: String, default: 'consul')

      # @!attribute binary_url
      # @return [String]
      attribute(:binary_url, kind_of: String)

      # @!attribute data_dir
      # @return [String]
      attribute(:data_dir, kind_of: String, default: '/var/lib/consul')

      # @!attribute config_dir
      # @return [String]
      attribute(:config_dir, kind_of: String, default: '/etc/consul')

      def binary_checksum
        node['consul']['checksums'].fetch(binary_filename)
      end

      def binary_filename
        arch = node['kernel']['machine'] =~ /x86_64/ ? 'amd64' : '386'
        [version, node['os'], arch].join('_')
      end
    end
  end

  module Provider
    # Provider for managing the Consul service on an instance.
    # @since 1.0.0
    class ConsulInstall < Chef::Provider
      include Poise
      provides(:consul_install)

      def action_install
        notifying_block do
            artifact = libartifact_file "consul-#{new_resource.version}" do
              artifact_name 'consul'
              artifact_version new_resource.version
              install_path new_resource.install_path
              remote_url new_resource.binary_url % { filename: new_resource.binary_filename }
              remote_checksum new_resource.binary_checksum
            end

            link '/usr/local/bin/consul' do
              to ::File.join(artifact.current_path, 'consul')
            end

          [new_resource.data_dir, new_resource.config_dir].each do |dirname|
            directory dirname do
              recursive true
              owner new_resource.user
              group new_resource.group
              mode '0755'
            end
          end
        end
      end

      def action_uninstall
        notifying_block do
          link '/usr/local/bin/consul' do
            action :delete
          end

          directory "#{new_resource.install_path}/consul" do
            recursive true
            action :delete
          end
        end
      end
    end
  end
end
