#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright (C) 2014, 2015 Bloomberg Finance L.P.
#
require 'poise'
require_relative 'helpers'

module ConsulCookbook
  module Provider
    # Provider for managing the Consul service on a Windows instance.
    # @since 1.0.0
    class ConsulServiceWindows < Chef::Provider
      include Poise
      include Chef::Mixin::ShellOut
      provides(:consul_service, os: %w{windows})
      include ConsulCookbook::Helpers

      def action_enable
        notifying_block do
          case new_resource.install_method
          when 'binary'
            windows_zipfile "consul-#{new_resource.version}" do
              action :unzip
              path new_resource.install_path
              source new_resource.binary_url % { version: new_resource.version, filename: new_resource.binary_filename('binary') }
              not_if { correct_version?(join_path(new_resource.install_path, 'consul.exe'), new_resource.version) }
            end
          else
            Chef::Application.fatal!('The Consul Service provider for Windows only supports the binary install_method at this time')
          end

          %W{#{new_resource.data_dir}
             #{new_resource.config_dir}
             #{::File.dirname(new_resource.nssm_params['AppStdout'])}
             #{::File.dirname(new_resource.nssm_params['AppStderr'])}}.uniq.each do |dirname|
            directory dirname do
              recursive true
              # owner new_resource.user
              # group new_resource.group
              # mode '0755'
            end
          end

          nssm 'consul' do
            action :install
            program join_path(new_resource.install_path, 'consul.exe')
            params new_resource.nssm_params
            args command(new_resource.config_file, new_resource.config_dir)
          end

          if nssm_service_installed?
            # The nssm resource does not check param values after they've been set
            mismatch_params = check_nssm_params
            unless mismatch_params.empty?
              mismatch_params.each do |k, v|
                batch "Set nssm parameter - #{k}" do
                  code "#{nssm_exe} set consul #{k} #{v}"
                  notifies :run, 'batch[Trigger consul restart]', :delayed
                end
              end
              batch 'Trigger consul restart' do
                action :nothing
                code "#{nssm_exe} restart consul"
              end
            end
            # Check if the service is running, but don't bother if we're already
            # changing some nssm parameters
            unless nssm_service_running? && mismatch_params.empty?
              batch 'Trigger consul restart' do
                action :run
                code "#{nssm_exe} restart consul"
              end
            end
          end
        end
      end

      def action_restart
        batch 'Restart consul' do
          code "#{nssm_exe} restart consul"
        end
      end

      def action_disable
        notifying_block do
          nssm 'consul' do
            action :remove
          end

          file new_resource.config_file do
            action :delete
          end
        end
      end
    end
  end
end
