# frozen_string_literal: true

require 'spec_helper'
require_relative '../libraries/helpers'

describe ConsulCookbook::Helpers do
  let(:helper_class) do
    Class.new do
      include ConsulCookbook::Helpers

      attr_accessor :node

      def platform_family?(family)
        node['platform_family'] == family
      end

      def platform?(name)
        node['platform'] == name
      end
    end
  end

  let(:helper) { helper_class.new }

  before do
    helper.node = {
      'platform' => 'ubuntu',
      'platform_family' => 'debian',
      'kernel' => { 'machine' => 'x86_64' },
    }
  end

  describe '#consul_arch' do
    context 'on x86_64' do
      it 'returns amd64' do
        expect(helper.consul_arch).to eq 'amd64'
      end
    end

    context 'on aarch64' do
      before { helper.node['kernel']['machine'] = 'aarch64' }

      it 'returns arm64' do
        expect(helper.consul_arch).to eq 'arm64'
      end
    end

    context 'on i686' do
      before { helper.node['kernel']['machine'] = 'i686' }

      it 'returns 386' do
        expect(helper.consul_arch).to eq '386'
      end
    end

    context 'on armv7l' do
      before { helper.node['kernel']['machine'] = 'armv7l' }

      it 'returns arm' do
        expect(helper.consul_arch).to eq 'arm'
      end
    end
  end

  describe '#config_prefix_path' do
    it 'returns /etc/consul' do
      expect(helper.config_prefix_path).to eq '/etc/consul'
    end
  end

  describe '#data_path' do
    it 'returns /var/lib/consul' do
      expect(helper.data_path).to eq '/var/lib/consul'
    end
  end

  describe '#command' do
    it 'generates a consul agent command' do
      expect(helper.command('/etc/consul/consul.json', '/etc/consul/conf.d')).to eq(
        '/usr/local/bin/consul agent -config-file=/etc/consul/consul.json -config-dir=/etc/consul/conf.d'
      )
    end

    it 'accepts a custom program path' do
      expect(helper.command('/etc/consul/consul.json', '/etc/consul/conf.d', '/usr/bin/consul')).to eq(
        '/usr/bin/consul agent -config-file=/etc/consul/consul.json -config-dir=/etc/consul/conf.d'
      )
    end
  end

  describe '#binary_archive_url' do
    it 'generates the correct URL' do
      expect(helper.binary_archive_url('1.22.5')).to eq(
        'https://releases.hashicorp.com/consul/1.22.5/consul_1.22.5_linux_amd64.zip'
      )
    end
  end

  describe '#binary_archive_basename' do
    it 'generates the correct basename' do
      expect(helper.binary_archive_basename('1.22.5')).to eq 'consul_1.22.5_linux_amd64.zip'
    end
  end

  describe '#hashicorp_repo_url' do
    context 'on debian' do
      it 'returns the apt repo URL' do
        expect(helper.hashicorp_repo_url).to eq 'https://apt.releases.hashicorp.com'
      end
    end

    context 'on rhel' do
      before { helper.node['platform_family'] = 'rhel' }

      it 'returns the RHEL yum repo URL' do
        expect(helper.hashicorp_repo_url).to eq 'https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo'
      end
    end

    context 'on amazon' do
      before { helper.node['platform_family'] = 'amazon' }

      it 'returns the AmazonLinux yum repo URL' do
        expect(helper.hashicorp_repo_url).to eq 'https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo'
      end
    end

    context 'on fedora' do
      before { helper.node['platform_family'] = 'fedora' }

      it 'returns the fedora repo URL' do
        expect(helper.hashicorp_repo_url).to eq 'https://rpm.releases.hashicorp.com/fedora/hashicorp.repo'
      end
    end

    context 'on suse' do
      before { helper.node['platform_family'] = 'suse' }

      it 'returns nil' do
        expect(helper.hashicorp_repo_url).to be_nil
      end
    end
  end
end
