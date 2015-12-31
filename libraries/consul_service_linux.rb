#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright (C) 2014, 2015 Bloomberg Finance L.P.
#
require 'poise_service/service_mixin'
require_relative 'helpers'

module ConsulCookbook
  module Provider
    # Provider for managing the Consul service on a Linux instance.
    # @since 1.0.0
    class ConsulServiceLinux < Chef::Provider
      include Poise
      provides :consul_service, os: %w(linux)
      include PoiseService::ServiceMixin
      include ConsulCookbook::Helpers

      def action_enable
        notifying_block do
          case new_resource.install_method
          when 'package'
            package new_resource.package_name do
              version new_resource.version unless new_resource.version.nil?
              only_if { new_resource.install_method == 'package' }
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
        service.command(new_resource.command new_resource.config_file, new_resource.config_dir)
        service.directory(new_resource.data_dir)
        service.user(new_resource.user)
        service.environment(new_resource.environment)
        service.restart_on_update(true)
      end
    end
  end
end
