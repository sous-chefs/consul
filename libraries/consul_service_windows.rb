#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
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
      provides(:consul_service, os: %w(windows))
      include ConsulCookbook::Helpers

      def application_path
        { 'Application' => new_resource.program }
      end

      def action_enable
        notifying_block do
          directories = %W(#{new_resource.data_dir}
                           #{new_resource.config_dir}
                           #{::File.dirname(new_resource.nssm_params['AppStdout'])}
                           #{::File.dirname(new_resource.nssm_params['AppStderr'])}).uniq.compact
          directories.delete_if { |i| i.eql? '.' }.each do |dirname|
            directory dirname do
              recursive true
            end
          end

          nssm 'consul' do
            extend ConsulCookbook::Helpers

            program new_resource.program
            args command(new_resource.config_file, new_resource.config_dir)
            parameters new_resource.nssm_params.select { |_k, v| v != '' }
            action :install
          end
        end
      end

      def action_reload
        notifying_block do
          execute 'Reload consul' do
            command 'consul.exe reload' + (new_resource.acl_token ? " -token=#{new_resource.acl_token}" : '')
            cwd ::File.dirname(new_resource.program)
            action :run
          end
        end
      end

      def action_restart
        notifying_block do
          powershell_script 'Restart consul' do
            code 'restart-service consul'
          end
        end
      end

      def action_disable
        notifying_block do
          nssm 'consul' do
            action %i(stop remove)
          end

          file new_resource.config_file do
            action :delete
          end
        end
      end
    end
  end
end
