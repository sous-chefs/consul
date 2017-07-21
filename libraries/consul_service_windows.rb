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
            if respond_to? :parameters
              parameters new_resource.nssm_params.select { |_k, v| v != '' }
            else
              params new_resource.nssm_params.select { |_k, v| v != '' }
            end
            action :install
            not_if { nssm_service_installed? }
          end

          if nssm_service_installed?
            mismatch_params = check_nssm_params(application_path)
            unless mismatch_params.empty?
              mismatch_params.each do |k, v|
                action = v.eql?('') ? "reset consul #{k}" : "set consul #{k} #{v}"
                batch "Set nssm parameter - #{k}" do
                  code "#{nssm_exe} #{action}"
                  notifies :run, 'powershell_script[Trigger consul restart]', :delayed
                end
              end
              powershell_script 'Trigger consul restart' do
                action :nothing
                code 'restart-service consul'
              end
            end
            # Check if the service is running, but don't bother if we're already
            # changing some nssm parameters
            powershell_script 'Trigger consul restart' do
              code 'restart-service consul'
              not_if { nssm_service_status?(%w(SERVICE_RUNNING)) && mismatch_params.empty? }
            end
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
          # nssm resource doesn't stop the service before it removes it
          powershell_script 'Stop consul' do
            extend ConsulCookbook::Helpers

            action :run
            code 'stop-service consul'
            only_if { nssm_service_installed? && nssm_service_status?(%w(SERVICE_RUNNING SERVICE_PAUSED)) }
          end

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
