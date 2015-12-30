require 'spec_helper'
require_relative '../../../libraries/consul_service'

describe ConsulCookbook::Resource::ConsulService do
  step_into(:consul_service)
  let(:chefspec_options) { {platform: 'ubuntu', version: '14.04'} }

  context 'with default properties' do
    recipe 'consul::default'

    it { expect(chef_run).to create_directory('/etc/consul/conf.d') }
    it { is_expected.to create_directory('/var/lib/consul') }
  end
end
