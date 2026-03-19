# frozen_string_literal: true

require 'spec_helper'

describe 'consul_installation' do
  step_into :consul_installation
  platform 'ubuntu', '24.04'

  context 'with repository install method on debian' do
    recipe do
      consul_installation 'latest' do
        install_method 'repository'
      end
    end

    it { is_expected.to install_package('apt-transport-https') }
    it { is_expected.to create_remote_file(File.join(Chef::Config[:file_cache_path], 'hashicorp-archive-keyring.asc')) }
    it { is_expected.to nothing_execute('dearmor-hashicorp-gpg') }
    it { is_expected.to install_package('consul') }
  end

  context 'with binary install method' do
    recipe do
      consul_installation '1.22.5' do
        install_method 'binary'
      end
    end

    it { is_expected.to create_remote_file(File.join(Chef::Config[:file_cache_path], 'consul_1.22.5_linux_amd64.zip')) }
    it { is_expected.to create_directory('/opt/consul/1.22.5') }
    it { is_expected.to create_link('/usr/local/bin/consul').with(to: '/opt/consul/1.22.5/consul') }
  end

  context 'with binary install method and custom checksum' do
    recipe do
      consul_installation '1.22.5' do
        install_method 'binary'
        checksum 'abc123'
      end
    end

    it { is_expected.to create_remote_file(File.join(Chef::Config[:file_cache_path], 'consul_1.22.5_linux_amd64.zip')).with(checksum: 'abc123') }
  end

  context 'action :remove with repository' do
    recipe do
      consul_installation 'latest' do
        install_method 'repository'
        action :remove
      end
    end

    it { is_expected.to remove_package('consul') }
  end

  context 'action :remove with binary' do
    recipe do
      consul_installation '1.22.5' do
        install_method 'binary'
        action :remove
      end
    end

    it { is_expected.to delete_link('/usr/local/bin/consul') }
    it { is_expected.to delete_directory('/opt/consul/1.22.5') }
  end
end

describe 'consul_installation on rhel' do
  step_into :consul_installation
  platform 'almalinux', '9'

  context 'with repository install method' do
    recipe do
      consul_installation 'latest' do
        install_method 'repository'
      end
    end

    it { is_expected.to create_yum_repository('hashicorp') }
    it { is_expected.to install_package('consul') }
  end
end
