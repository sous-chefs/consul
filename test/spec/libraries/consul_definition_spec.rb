require 'spec_helper'
require_relative '../../../libraries/consul_definition'

describe ConsulCookbook::Resource::ConsulDefinition do
  step_into(:consul_definition)
  let(:chefspec_options) { {platform: 'ubuntu', version: '14.04'} }

  context 'service definition' do
    recipe do
      consul_definition 'redis' do
        type 'service'
        parameters(tags: %w{master}, address: '127.0.0.1', port: 6379, interval: '10s')
      end
    end

    it { is_expected.to create_directory('/etc/consul') }
    it do
      is_expected.to create_file('/etc/consul/redis.json')
      .with(user: 'consul', group: 'consul', mode: '0640')
      .with(content: JSON.pretty_generate(
        service: {
          tags: ['master'],
          address: '127.0.0.1',
          port: 6379,
          interval: '10s',
          name: 'redis'
        }
      ))
    end
  end

  context 'service definition with explicit name' do
    recipe do
      consul_definition 'redis' do
        type 'service'
        parameters(name: 'myredis', tags: %w{master}, address: '127.0.0.1', port: 6379, interval: '10s')
      end
    end

    it { is_expected.to create_directory('/etc/consul') }
    it do
      is_expected.to create_file('/etc/consul/redis.json')
      .with(user: 'consul', group: 'consul', mode: '0640')
      .with(content: JSON.pretty_generate(
        service: {
          name: 'myredis',
          tags: ['master'],
          address: '127.0.0.1',
          port: 6379,
          interval: '10s'
        }
      ))
    end
  end

  context 'check definition' do
    recipe do
      consul_definition 'web-api' do
        type 'check'
        parameters(http: 'http://localhost:5000/health', ttl: '30s')
      end
    end

    it { is_expected.to create_directory('/etc/consul') }
    it do
      is_expected.to create_file('/etc/consul/web-api.json')
      .with(user: 'consul', group: 'consul', mode: '0640')
      .with(content: JSON.pretty_generate(
        check: {
          http: 'http://localhost:5000/health',
          ttl: '30s',
          name: 'web-api',
        }
      ))
    end
  end
end
