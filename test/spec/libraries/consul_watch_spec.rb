require 'spec_helper'
require_relative '../../../libraries/consul_watch'

describe ConsulCookbook::Resource::ConsulWatch do
  step_into(:consul_watch)
  let(:chefspec_options) { {platform: 'ubuntu', version: '14.04'} }

  context 'key watch' do
    recipe do
      consul_watch 'foo' do
        type 'key'
        parameters(key: 'foo/bar/baz', handler: '/bin/false')
      end
    end

    it { is_expected.to create_directory('/etc/consul') }
    it do
      is_expected.to create_file('/etc/consul/foo.json')
      .with(user: 'consul', group: 'consul', mode: '0640')
      .with(content: JSON.pretty_generate(
        {
          watches: [
            {
              type: 'key',
              key: 'foo/bar/baz',
              handler: '/bin/false'
            }
          ]
        }
      ))
    end
  end
end
