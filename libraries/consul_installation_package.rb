#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise'

module ConsulCookbook
  module Provider
    # A `consul_installation` provider which installs Consul from
    # package source.
    # @action create
    # @action remove
    # @provides consul_installation
    # @example
    #   consul_installation '0.5.0' do
    #     provider 'package'
    #   end
    # @since 2.0
    class ConsulInstallationPackage < Chef::Provider
      include Poise(inversion: :consul_installation)
      provides(:package)
      inversion_attribute 'consul'

      # The built-in resource "package" has it's own attribute named "options",
      # so we should use an alias to access Poise inversion options.
      alias res_options options

      # Set the default inversion options.
      # @return [Hash]
      # @api private
      def self.default_inversion_options(node, resource)
        super.merge(
          version: resource.version,
          package_name: 'consul'
        )
      end

      def action_create
        notifying_block do
          package res_options[:package_name] do
            source res_options[:package_source]
            provider res_options[:package_provider]
            version res_options[:version]
            action :upgrade
          end
        end
      end

      def action_remove
        notifying_block do
          package res_options[:package_name] do
            source res_options[:package_source]
            provider res_options[:package_provider]
            version res_options[:version]
            action :remove
          end
        end
      end

      def consul_program
        options.fetch(:program, '/usr/local/bin/consul')
      end
    end
  end
end
