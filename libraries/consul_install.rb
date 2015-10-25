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

      # @!attribute install_method
      # @return [Symbol]
      attribute(:install_method, equal_to: %w{source binary package}, name_attribute: true, required: true)

      # @!attribute install_path
      # @return [String]
      attribute(:install_path, kind_of: String, default: '/srv')

      # @!attribute user
      # @return [String]
      attribute(:user, kind_of: String, default: 'consul')

      # @!attribute group
      # @return [String]
      attribute(:group, kind_of: String, default: 'consul')

      # @!attribute package_name
      # @return [String]
      attribute(:package_name, kind_of: String, default: 'consul')

      # @!attribute binary_url
      # @return [String]
      attribute(:binary_url, kind_of: String)

      # @!attribute source_url
      # @return [String]
      attribute(:source_url, kind_of: String)

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
          if new_resource.install_method == 'package'
            if node['platform'] == 'windows'
              include_recipe 'chocolatey::default'

              chocolatey new_resource.package_name do
                version new_resource.version
              end
            else
              package new_resource.package_name do
                version new_resource.version unless new_resource.version.nil?
              end
            end
          end

          if new_resource.install_method == 'binary'
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
          end

          if new_resource.install_method == 'source'
            include_recipe 'golang::default'

            source_dir = directory ::File.join(new_resource.install_path, 'consul', 'src') do
              recursive true
              owner new_resource.user
              group new_resource.group
              mode '0755'
            end

            git ::File.join(source_dir.path, "consul-#{new_resource.version}") do
              repository new_resource.source_url
              reference new_resource.version
              action :checkout
            end

            golang_package 'github.com/hashicorp/consul' do
              action :install
            end

            directory ::File.join(new_resource.install_path, 'bin') do
              recursive true
              owner new_resource.user
              group new_resource.group
              mode '0755'
            end

            link ::File.join(new_resource.install_path, 'bin', 'consul') do
              to ::File.join(source_dir.path, "consul-#{new_resource.version}", 'consul')
            end
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
          if new_resource.install_method == 'package'
            package new_resource.package_name do
              action :remove
              not_if { node[:platform] == 'windows' }
            end

            chocolatey new_resource.package_name do
              action :remove
              only_if { node[:platform] == 'windows' }
            end
          end

          link '/usr/local/bin/consul' do
            action :delete
            only_if { new_resource.install_method == 'binary' }
          end

          directory "#{new_resource.install_path}/consul" do
            recursive true
            action :delete
            only_if { %w[binary source].include? new_resource.install_method }
          end
        end
      end
    end
  end
end
