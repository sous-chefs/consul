require 'poise_boiler/spec_helper'
require_relative '../../../libraries/consul_definition'

describe ConsulCookbook::Resource::ConsulDefinition do
  step_into(:consul_definition)

  context 'service definition' do
    recipe do
      consul_definition 'redis' do
        type 'service'
        parameters(tags: %w{master}, address: '127.0.0.1', port: 6379)
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
        },
        quicks_mode: true
      ))
    end
  end
end
