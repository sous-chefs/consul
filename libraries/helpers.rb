# frozen_string_literal: true

#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright:: 2014-2016, Bloomberg Finance L.P.
#

module ConsulCookbook
  module Helpers
    include Chef::Mixin::ShellOut

    extend self

    def consul_arch
      case node['kernel']['machine']
      when 'x86_64', 'amd64' then 'amd64'
      when /i\d86/ then '386'
      when /^arm/ then 'arm'
      when 'aarch64' then 'arm64'
      else node['kernel']['machine']
      end
    end

    def config_prefix_path
      '/etc/consul'
    end

    def data_path
      '/var/lib/consul'
    end

    def command(config_file, config_dir, program = '/usr/local/bin/consul')
      "#{program} agent -config-file=#{config_file} -config-dir=#{config_dir}"
    end

    def hashicorp_repo_url
      case node['platform_family']
      when 'debian'
        'https://apt.releases.hashicorp.com'
      when 'rhel', 'amazon'
        "https://rpm.releases.hashicorp.com/#{node['platform_family'] == 'amazon' ? 'AmazonLinux' : 'RHEL'}/hashicorp.repo"
      when 'fedora'
        'https://rpm.releases.hashicorp.com/fedora/hashicorp.repo'
      when 'suse'
        nil
      end
    end

    def hashicorp_gpg_key_url
      'https://apt.releases.hashicorp.com/gpg'
    end

    def resolve_binary_version(version)
      return version unless version == 'latest'

      require 'net/http'
      require 'json'
      uri = URI('https://checkpoint-api.hashicorp.com/v1/check/consul')
      response = Net::HTTP.get_response(uri)
      JSON.parse(response.body)['current_version']
    end

    def binary_archive_url(version)
      basename = "consul_#{version}_linux_#{consul_arch}.zip"
      "https://releases.hashicorp.com/consul/#{version}/#{basename}"
    end

    def binary_archive_basename(version)
      "consul_#{version}_linux_#{consul_arch}.zip"
    end
  end
end
