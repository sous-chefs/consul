# frozen_string_literal: true

require 'spec_helper'

describe 'consul_definition' do
  step_into :consul_definition
  platform 'ubuntu', '24.04'

  context 'creates a service definition' do
    recipe do
      consul_definition 'redis' do
        type 'service'
        parameters(tags: %w(master), address: '127.0.0.1', port: 6379)
      end
    end

    it { is_expected.to create_directory('/etc/consul/conf.d') }
    it { is_expected.to create_file('/etc/consul/conf.d/redis.json').with(owner: 'consul', group: 'consul', mode: '0640') }
  end

  context 'creates a check definition' do
    recipe do
      consul_definition 'mem-util' do
        type 'check'
        parameters(script: '/usr/local/bin/check_mem.py', interval: '10s')
      end
    end

    it { is_expected.to create_file('/etc/consul/conf.d/mem-util.json').with(owner: 'consul', group: 'consul', mode: '0640') }
  end

  context 'with custom path' do
    recipe do
      consul_definition 'custom' do
        type 'service'
        path '/opt/consul/conf.d/custom.json'
      end
    end

    it { is_expected.to create_directory('/opt/consul/conf.d') }
    it { is_expected.to create_file('/opt/consul/conf.d/custom.json') }
  end

  context 'action :delete' do
    recipe do
      consul_definition 'redis' do
        type 'service'
        action :delete
      end
    end

    it { is_expected.to delete_file('/etc/consul/conf.d/redis.json') }
  end
end
