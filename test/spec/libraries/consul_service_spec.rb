require 'spec_helper'
require_relative '../../../libraries/consul_service'

describe ConsulCookbook::Resource::ConsulService do
  step_into(:consul_service)
  let(:chefspec_options) { {platform: 'ubuntu', version: '14.04'} }

  context 'with default properties' do
    recipe 'consul::default'

    it {
      is_expected.to enable_consul_service('consul')
      .with(user:  'consul')
      .with(group: 'consul')
      .with(config_dir: '/etc/consul')
      .with(config_file: '/etc/consul.json')
    }
  end
end
