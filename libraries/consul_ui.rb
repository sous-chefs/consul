require 'poise'

module ConsulCookbook
  module Resource
    # Resource for managing the Consul web UI installation.
    class ConsulUI < Chef::Resource
      include Poise
      provides(:consul_ui)
      default_action(:install)

      # @!attribute version
      # @return [String]
      attribute(:version, kind_of: String, required: true)

      # @!attribute install_path
      # @return [String]
      attribute(:install_path, kind_of: String, default: '/srv')

      # @!attribute owner
      # @return [String]
      attribute(:owner, kind_of: String, default: 'consul')

      # @!attribute group
      # @return [String]
      attribute(:group, kind_of: String, default: 'consul')

      # @!attribute binary_url
      # @return [String]
      attribute(:binary_url, kind_of: String, default: 'https://dl.bintray.com/mitchellh/consul/%{filename}.zip')

      # @!attribute source_url
      # @return [String]
      attribute(:source_url, kind_of: String)

      def default_environment
        { GOMAXPROCS: [node['cpu']['total'], 2].max.to_s, PATH: '/usr/local/bin:/usr/bin:/bin' }
      end

      def binary_checksum
        node['consul']['checksums'].fetch(binary_filename)
      end

      def binary_filename
        [version, 'web_ui'].join('_')
      end
    end
  end

  module Provider
    # Provider for managing the Consul web UI installation.
    class ConsulUI < Chef::Provider
      include Poise
      provides(:consul_ui)

      def action_install
        notifying_block do
          libartifact_file "#{new_resource.name}-#{new_resource.version}" do
            artifact_name new_resource.name
            artifact_version new_resource.version
            owner new_resource.owner
            group new_resource.group
            install_path new_resource.install_path
            remote_url new_resource.binary_url % { filename: new_resource.binary_filename }
            remote_checksum new_resource.binary_checksum
          end
        end
      end

      def action_uninstall
        notifying_block do
          libartifact_file "#{new_resource.name}-#{new_resource.version}" do
            action :delete
            artifact_name new_resource.name
            artifact_version new_resource.version
            install_path new_resource.install_path
          end
        end
      end
    end
  end
end
