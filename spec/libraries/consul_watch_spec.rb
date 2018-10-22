require 'spec_helper'
require_relative '../../libraries/consul_watch'

describe ConsulCookbook::Resource::ConsulWatch do
  step_into(:consul_watch)
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

  context 'key watch' do
    recipe do
      consul_watch 'foo' do
        type 'key'
        user 'root'
        parameters(key: 'foo/bar/baz', handler: '/bin/false')
      end
    end

    it { is_expected.to create_directory('/etc/consul/conf.d') }
    it do
      is_expected.to create_file('/etc/consul/conf.d/foo.json')
        .with(user: 'root', group: 'consul', mode: '0640')
        .with(content: JSON.pretty_generate(
          watches: [
            {
              type: 'key',
              key: 'foo/bar/baz',
              handler: '/bin/false',
            },
          ]
        ))
    end
  end
end
