# frozen_string_literal: true

require 'spec_helper'

describe 'consul_config' do
  step_into :consul_config
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      consul_config '/etc/consul/consul.json'
    end

    it { is_expected.to create_directory('/etc/consul').with(owner: 'consul', group: 'consul', mode: '0755') }
    it { is_expected.to create_directory('/etc/consul/conf.d').with(owner: 'consul', group: 'consul', mode: '0755') }
    it { is_expected.to create_file('/etc/consul/consul.json').with(owner: 'consul', group: 'consul', mode: '0640') }
  end

  context 'with server mode' do
    recipe do
      consul_config '/etc/consul/consul.json' do
        owner 'root'
        group 'consul'
        server true
        bootstrap true
        datacenter 'FortMeade'
        encrypt 'CGXC2NsXW4AvuB4h5ODYzQ=='
        ui true
      end
    end

    it { is_expected.to create_file('/etc/consul/consul.json').with(owner: 'root', group: 'consul', mode: '0640') }

    it 'renders config with server settings' do
      expect(chef_run).to create_file('/etc/consul/consul.json').with(sensitive: true)
    end
  end

  context 'with custom config_dir' do
    recipe do
      consul_config '/etc/consul/consul.json' do
        config_dir '/etc/consul/custom.d'
      end
    end

    it { is_expected.to create_directory('/etc/consul/custom.d') }
  end

  context 'action :delete' do
    recipe do
      consul_config '/etc/consul/consul.json' do
        action :delete
      end
    end

    it { is_expected.to delete_file('/etc/consul/consul.json') }
  end
end
