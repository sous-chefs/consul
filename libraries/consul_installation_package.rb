#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
require 'poise'

module ConsulCookbook
  module Resource
    # A `consul_installation_package` resource.
    # @action create
    # @action remove
    # @provides consul_installation
    # @provides consul_installation_package
    # @since 2.0
    class ConsulInstallationPackage < Chef::Resource
      include Poise(fused: true)
      provides(:consul_installation_package)

      # @!attribute package_version
      # @return [String]
      attribute(:package_version, kind_of: String, name_attribute: true)
      # @!attribute package_name
      # @return [String]
      attribute(:package_name, kind_of: String, default: 'consul')
      # @!attribute package_source
      # @return [String]
      attribute(:package_source, kind_of: String)

      action(:create) do
        notifying_block do
          package new_resource.package_name do
            version new_resource.package_version if new_resource.package_version
            source new_resource.package_source if new_resource.package_source
            action :upgrade
          end
        end
      end

      action(:remove) do
        notifying_block do
          package new_resource.package_name do
            version new_resource.package_version if new_resource.package_version
            action :remove
          end
        end
      end
    end
  end
end
