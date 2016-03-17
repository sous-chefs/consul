#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise'

module ConsulCookbook
  module Resource
    # A `consul_installation` resource which manages the Consul installation.
    # @action create
    # @action remove
    # @since 2.0
    class ConsulInstallation < Chef::Resource
      include Poise(inversion: true)
      provides(:consul_installation)
      actions(:create, :remove)
      default_action(:create)

      # @!attribute version
      # The version of Consul to install.
      # @return [String]
      attribute(:version, kind_of: String, name_attribute: true)

      def consul_program
        @program ||= provider_for_action(:consul_program).consul_program
      end
    end
  end
end
