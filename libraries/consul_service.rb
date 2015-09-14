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
    class ConsulService < Chef::Resource
      include Poise
      provides(:consul_service)
      include PoiseService::ServiceMixin

      # @!attribute version
      # @return [String]
      attribute(:version, kind_of: String, required: true)

      # @!attribute install_method
      # @return [Symbol]
      attribute(:install_method, default: 'binary', equal_to: %w{source binary package})

      # @!attribute install_path
      # @return [String]
      attribute(:install_path, kind_of: String, default: '/srv')

      # @!attribute config_file
      # @return [String]
      attribute(:config_file, kind_of: String, default: '/etc/consul.json')

      # @!attribute user
      # @return [String]
      attribute(:user, kind_of: String, default: 'consul')

      # @!attribute group
      # @return [String]
      attribute(:group, kind_of: String, default: 'consul')

      # @!attribute environment
      # @return [String]
      attribute(:environment, kind_of: Hash, default: lazy { default_environment })

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

      def default_environment
        {
          'GOMAXPROCS' => [node['cpu']['total'], 2].max.to_s,
          'PATH' => '/usr/local/bin:/usr/bin:/bin'
        }
      end

      def command
        "/usr/bin/env consul agent -config-file=#{config_file} -config-dir=#{config_dir}"
      end

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
    class ConsulService < Chef::Provider
      include Poise
      provides(:consul_service)
      include PoiseService::ServiceMixin

      def action_enable
        notifying_block do
          package new_resource.package_name do
            version new_resource.version unless new_resource.version.nil?
            only_if { new_resource.install_method == 'package' }
          end

          if node['platform'] == 'windows'
            include_recipe 'chocolatey::default'

            chocolatey new_resource.package_name do
              version new_resource.version
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
        super
      end

      def action_disable
        notifying_block do
          file new_resource.config_file do
            action :delete
          end
        end
        super
      end

      def service_options(service)
        service.command(new_resource.command)
        service.directory(new_resource.data_dir)
        service.user(new_resource.user)
        service.environment(new_resource.environment)
        service.restart_on_update(true)
      end
    end
  end
end
