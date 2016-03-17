#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise'

module ConsulCookbook
  module Provider
    # A `consul_installation` provider which manages Consul installation
    # from the Go source builds.
    # @action create
    # @action remove
    # @provides consul_installation
    # @example
    #   consul_installation '0.5.0' do
    #     provider 'git'
    #   end
    # @since 2.0
    class ConsulInstallationGit < Chef::Provider
      include Poise(inversion: :consul_installation)
      provides(:git)
      inversion_attribute('consul')

      # Set the default inversion options.
      # @return [Hash]
      # @api private
      def self.default_inversion_options(node, resource)
        super.merge(
          version: resource.version,
          git_url: 'https://github.com/hashicorp/consul',
          git_path: '/usr/local/src/consul'
        )
      end

      def action_create
        notifying_block do
          include_recipe 'golang::default', 'build-essential::default'
          golang_package 'github.com/mitchellh/gox'
          golang_package 'github.com/tools/godep'

          git options[:git_path] do
            repository options[:git_url]
            reference options.fetch(:git_ref, "v#{new_resource.version}")
            action :checkout
          end

          execute 'make' do
            cwd options[:git_path]
            environment(PATH: "#{node['go']['install_dir']}/go/bin:#{node['go']['gobin']}:/usr/bin:/bin",
                        GOPATH: node['go']['gopath'])
          end
        end
      end

      def action_remove
        notifying_block do
          directory options[:git_path] do
            recursive true
            action :delete
          end
        end
      end

      def consul_program
        ::File.join(options[:git_path], 'bin', 'consul')
      end
    end
  end
end
