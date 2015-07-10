require 'poise_boiler/spec_helper'
require 'poise'

RSpec.configure do |config|
  config.include Halite::SpecHelper
end

require_relative '../../../libraries/consul_watch'

describe Chef::Resource::ConsulWatch do
  step_into(:consul_watch)

  context 'defines key watch' do
    recipe do
      consul_watch '/etc/consul/watches/foo.json' do
        type 'key'
        parameters(key: 'foo/bar/baz', handler: '/bin/false')
      end
    end

    it { is_expected.to create_directory('/etc/consul/watches') }
    it do
      is_expected.to create_file('/etc/consul/watches/foo.json')
      .with(user: 'consul', group: 'consul', mode: '0640')
      .with(content: JSON.pretty_generate(
        {
          type: 'key',
          key: 'foo/bar/baz',
          handler: '/bin/false'
        },
        quicks_mode: true
      ))
    end
  end
end
