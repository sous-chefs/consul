#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise_service/service_mixin'
require_relative 'helpers'

module ConsulCookbook
  module Resource
    # A resource for managing the Consul service.
    # @since 1.0.0
    class ConsulService < Chef::Resource
      include Poise
      provides(:consul_service)
      include PoiseService::ServiceMixin
      include ConsulCookbook::Helpers

      # @!attribute version
      # @return [String]
      attribute(:version, kind_of: String, required: true)

      # @!attribute install_method
      # @return [Symbol]
      attribute(:install_method, default: 'binary', equal_to: %w{source binary package})

      # @!attribute install_path
      # @return [String]
      attribute(:install_path, kind_of: String, default: lazy { node['consul']['service']['install_path'] })

      # @!attribute config_file
      # @return [String]
      attribute(:config_file, kind_of: String, default: lazy { node['consul']['config']['path'] })

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
      attribute(:data_dir, kind_of: String, default: lazy { node['consul']['config']['data_dir'] })

      # @!attribute config_dir
      # @return [String]
      attribute(:config_dir, kind_of: String, default: lazy { node['consul']['config']['config_dir'] })

      # @!attribute nssm_params
      # @return [String]
      attribute(:nssm_params, kind_of: Hash, default: lazy { node['consul']['service']['nssm_params'] })
    end
  end

  module Provider
    # A provider for managing the Consul service.
    # @since 1.0.0
    class ConsulService < Chef::Provider
      include Poise
      provides(:consul_service)
      include PoiseService::ServiceMixin
      include ConsulCookbook::Helpers

      def action_enable
        notifying_block do
          case new_resource.install_method
          when 'package'
            package new_resource.package_name do
              version new_resource.version unless new_resource.version.nil?
            end
          when 'binary'
            artifact = libartifact_file "consul-#{new_resource.version}" do
              artifact_name 'consul'
              artifact_version new_resource.version
              install_path new_resource.install_path
              remote_url new_resource.binary_url % { version: new_resource.version, filename: new_resource.binary_filename('binary') }
              remote_checksum new_resource.binary_checksum 'binary'
            end

            link '/usr/local/bin/consul' do
              to join_path(artifact.current_path, 'consul')
            end
          when 'source'
            include_recipe 'golang::default'

            source_dir = directory join_path(new_resource.install_path, 'consul', 'src') do
              recursive true
              owner new_resource.user
              group new_resource.group
              mode '0755'
            end

            git join_path(source_dir.path, "consul-#{new_resource.version}") do
              repository new_resource.source_url
              reference new_resource.version
              action :checkout
            end

            golang_package 'github.com/hashicorp/consul' do
              action :install
            end

            directory join_path(new_resource.install_path, 'bin') do
              recursive true
              owner new_resource.user
              group new_resource.group
              mode '0755'
            end

            link join_path(new_resource.install_path, 'bin', 'consul') do
              to join_path(source_dir.path, "consul-#{new_resource.version}", 'consul')
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
        service.command(new_resource.command(new_resource.config_file, new_resource.config_dir))
        service.directory(new_resource.data_dir)
        service.user(new_resource.user)
        service.environment(new_resource.environment)
        service.restart_on_update(true)
        service.options(:systemd, template: 'consul:systemd.service.erb')
        service.options(:sysvinit, template: 'consul:sysvinit.service.erb')

        if node.platform_family?('rhel') && node.platform_version.to_i == 6
          service.provider(:sysvinit)
        end
      end
    end
  end
end
