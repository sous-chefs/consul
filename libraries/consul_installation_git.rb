#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise'

module ConsulCookbook
  module Resource
    # A `consul_installation` resource which manages the Consul installation
    # from the main git repository.
    # @action create
    # @action remove
    # @provides consul_installation
    # @provides consul_installation_git
    # @since 2.0
    class ConsulInstallationGit < Chef::Resource
      include Poise(fused: true)
      provides(:consul_installation_git)

      # @!attribute git_url
      # @return [String]
      attribute(:git_url, kind_of: String, required: true)
      # @!attribute git_ref
      # @return [String]
      attribute(:git_ref, kind_of: String, default: 'master')
      # @!attribute git_path
      # @return [String]
      attribute(:git_path, kind_of: String, default: '/usr/local/src/consul')

      action(:create) do
        notifying_block do
          include_recipe 'golang::default'

          git new_resource.git_path do
            repository new_resource.git_url
            reference new_resource.git_ref
            action :checkout
          end

          golang_package 'github.com/hashicorp/consul' do
            action :install
          end

          link '/usr/local/bin/consul' do
            to ::File.join(new_resource.git_path, 'bin', 'consul')
          end
        end
      end

      action(:remove) do
        notifying_block do
          directory new_resource.git_path do
            recursive true
            action :delete
          end

          link ::File.join(new_resource.git_path, 'bin', 'consul') do
            to new_resource.target_path
            only_if { new_resource.target_path }
            action :delete
          end
        end
      end
    end
  end
end
