require 'spec_helper'
require_relative '../../libraries/consul_definition'

describe ConsulCookbook::Resource::ConsulDefinition do
  step_into(:consul_definition)
  let(:chefspec_options) { { platform: 'ubuntu', version: '14.04' } }
  before do
    default_attributes['consul'] = {
      'service_user' => 'consul',
      'service_group' => 'consul',
      'service' => {
        'config_dir' => '/etc/consul/conf.d',
      },
    }
  end

  context 'service definition' do
    recipe do
      consul_definition 'redis' do
        type 'service'
        user 'root'
        parameters(tags: %w(master), address: '127.0.0.1', port: 6379, interval: '10s')
      end
    end

    it { is_expected.to create_directory('/etc/consul/conf.d') }
    it do
      is_expected.to create_file('/etc/consul/conf.d/redis.json')
        .with(user: 'root', group: 'consul', mode: '0644')
        .with(content: JSON.pretty_generate(
          service: {
            tags: ['master'],
            address: '127.0.0.1',
            port: 6379,
            interval: '10s',
            name: 'redis',
          }
        ))
    end
  end

  context 'service definition with explicit name' do
    recipe do
      consul_definition 'redis' do
        type 'service'
        user 'root'
        parameters(name: 'myredis', tags: %w(master), address: '127.0.0.1', port: 6379, interval: '10s')
      end
    end

    it { is_expected.to create_directory('/etc/consul/conf.d') }
    it do
      is_expected.to create_file('/etc/consul/conf.d/redis.json')
        .with(user: 'root', group: 'consul', mode: '0644')
        .with(content: JSON.pretty_generate(
          service: {
            name: 'myredis',
            tags: ['master'],
            address: '127.0.0.1',
            port: 6379,
            interval: '10s',
          }
        ))
    end
  end

  context 'service definition with owner and group from node config' do
    before do
      default_attributes['consul'] = {
        'service_user' => 'root',
        'service_group' => 'root',
        'service' => {
          'config_dir' => '/etc/consul/conf.d',
        },
      }
    end

    recipe do
      consul_definition 'redis' do
        type 'service'
        parameters(name: 'myredis', tags: %w(master), address: '127.0.0.1', port: 6379, interval: '10s')
      end
    end

    it { is_expected.to create_directory('/etc/consul/conf.d') }
    it do
      is_expected.to create_file('/etc/consul/conf.d/redis.json')
        .with(user: 'root', group: 'root', mode: '0644')
        .with(content: JSON.pretty_generate(
          service: {
            name: 'myredis',
            tags: ['master'],
            address: '127.0.0.1',
            port: 6379,
            interval: '10s',
          }
        ))
    end
  end

  context 'check definition' do
    recipe do
      consul_definition 'web-api' do
        type 'check'
        user 'root'
        parameters(http: 'http://localhost:5000/health', ttl: '30s')
      end
    end

    it { is_expected.to create_directory('/etc/consul/conf.d') }
    it do
      is_expected.to create_file('/etc/consul/conf.d/web-api.json')
        .with(user: 'root', group: 'consul', mode: '0644')
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
