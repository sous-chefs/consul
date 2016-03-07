#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise'

module ConsulCookbook
  module Provider
    # A `consul_installation` provider which manages Consul Web UI
    # remote installation.
    # @action create
    # @action remove
    # @provides consul_installation
    # @example
    #   consul_installation '0.5.0' do
    #     provider 'webui'
    #   end
    # @since 2.0
    class ConsulInstallationWebui < Chef::Provider
      include Poise(inversion: :consul_installation)
      provides(:webui)
      inversion_attribute 'consul'

      # Set the default inversion options.
      # @return [Hash]
      # @api private
      def self.default_inversion_options(node, resource)
        archive_basename = binary_basename(node, resource)
        super.merge(
          version: resource.version,
          archive_url: default_archive_url % { version: resource.version, basename: archive_basename },
          archive_basename: archive_basename,
          archive_checksum: binary_checksum(node, resource),
          extract_to: '/opt/consul-webui'
        )
      end

      def action_create
        archive_url = options[:archive_url] % {
          version: options[:version],
          basename: options[:archive_basename]
        }

        notifying_block do
          include_recipe 'libarchive::default'

          archive = remote_file options[:archive_basename] do
            path ::File.join(Chef::Config[:file_cache_path], name)
            source archive_url
            checksum options[:archive_checksum]
          end

          directory ::File.join(options[:extract_to], new_resource.version) do
            recursive true
          end

          libarchive_file options[:archive_basename] do
            path archive.path
            mode options[:extract_mode]
            owner options[:extract_owner]
            group options[:extract_group]
            extract_to ::File.join(options[:extract_to], new_resource.version)
            extract_options options[:extract_options]
          end
        end
      end

      def action_remove
        notifying_block do
          directory ::File.join(options[:extract_to], new_resource.version) do
            recursive true
            action :delete
          end
        end
      end

      def consul_binary
        ::File.join(options[:extract_to], new_resource.version, 'consul')
      end

      def self.default_archive_url
        "https://releases.hashicorp.com/consul/%{version}/%{basename}" # rubocop:disable Style/StringLiterals
      end

      def self.binary_basename(node, resource)
        ['consul', resource.version, 'web_ui'].join('_').concat('zip')
      end

      def self.binary_checksum(node, resource)
        case resource.version
        when '0.5.0' then '0081d08be9c0b1172939e92af5a7cf9ba4f90e54fae24a353299503b24bb8be9'
        when '0.5.1' then 'ad883aa52e1c0136ab1492bbcedad1210235f26d59719fb6de3ef6464f1ff3b1'
        when '0.5.2' then 'ad883aa52e1c0136ab1492bbcedad1210235f26d59719fb6de3ef6464f1ff3b1'
        when '0.6.0' then '73c5e7ee50bb4a2efe56331d330e6d7dbf46335599c028344ccc4031c0c32eb0'
        when '0.6.1' then 'afccdd540b166b778c7c0483becc5e282bbbb1ee52335bfe94bf757df8c55efc'
        when '0.6.2' then 'f144377b8078df5a3f05918d167a52123089fc47b12fc978e6fb375ae93afc90'
        when '0.6.3' then '93bbb300cacfe8de90fb3bd5ede7d37ae6ce014898edc520b9c96a676b2bbb72'
        end
      end
    end
  end
end
