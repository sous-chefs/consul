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
    # A `consul_service` resource for use with `poise_service`. This
    # resource manages the Consul service.
    # @since 1.0
    class ConsulService < Chef::Resource
      include Poise
      provides(:consul_service)
      include PoiseService::ServiceMixin
      include ConsulCookbook::Helpers

      # @!attribute config_file
      # @return [String]
      attribute(:config_file, kind_of: String, default: lazy { node['consul']['config']['path'] })
      # @!attribute user
      # The service user the Consul process runs as.
      # @return [String]
      attribute(:user, kind_of: String, default: lazy { node['consul']['service_user'] })
      # @!attribute group
      # The service group the Consul process runs as.
      # @return [String]
      attribute(:group, kind_of: String, default: lazy { node['consul']['service_group'] })
      # @!attribute environment
      # The environment that the Consul process starts with.
      # @return [String]
      attribute(:environment, kind_of: Hash, default: lazy { default_environment })
      # @!attribute data_dir
      # @return [String]
      attribute(:data_dir, kind_of: String, default: lazy { node['consul']['config']['data_dir'] })
      # @!attribute config_dir
      # @return [String]
      attribute(:config_dir, kind_of: String, default: lazy { node['consul']['service']['config_dir'] })
      # @!attribute nssm_params
      # @return [String]
      attribute(:nssm_params, kind_of: Hash, default: lazy { node['consul']['service']['nssm_params'] })
      # @!attribute program
      # The location of the Consul executable.
      # @return [String]
      attribute(:program, kind_of: String, default: '/usr/local/bin/consul')
      # @!attribute acl_token
      # The ACL token. Needed to reload the Consul service on Windows
      # @return [String]
      attribute(:acl_token, kind_of: String, default: lazy { node['consul']['config']['acl_master_token'] })

      def command
        "#{program} agent -config-file=#{config_file} -config-dir=#{config_dir}"
      end

      def shell_environment
        shell = node['consul']['service_shell']
        shell.nil? ? {} : { 'SHELL' => shell }
      end

      def default_environment
        {
          'GOMAXPROCS' => [node['cpu']['total'], 2].max.to_s,
          'PATH' => '/usr/local/bin:/usr/bin:/bin',
        }.merge(shell_environment)
      end
    end
  end

  module Provider
    # A provider for managing the Consul service.
    # @since 1.0
    class ConsulService < Chef::Provider
      include Poise
      provides(:consul_service)
      include PoiseService::ServiceMixin

      def action_enable
        notifying_block do
          directory new_resource.data_dir do
            recursive true
            owner new_resource.user
            group new_resource.group
            mode '0750'
          end
        end
        super
      end

      def service_options(service)
        service.command(new_resource.command)
        service.directory(new_resource.data_dir)
        service.user(new_resource.user)
        service.environment(new_resource.environment)
        service.restart_on_update(false)
        service.options(:systemd, template: 'consul:systemd.service.erb')
        service.options(:sysvinit, template: 'consul:sysvinit.service.erb')
        service.options(:upstart, template: 'consul:upstart.service.erb', executable: new_resource.program)

        if node.platform_family?('rhel') && node['platform_version'].to_i == 6
          service.provider(:sysvinit)
        end
      end
    end
  end
end

