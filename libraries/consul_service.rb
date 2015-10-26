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
    end
  end

  module Provider
    # Provider for managing the Consul service on an instance.
    # @since 1.0.0
    class ConsulService < Chef::Provider
      include Poise
      provides(:consul_service)
      include PoiseService::ServiceMixin

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
