require 'spec_helper'
require_relative '../../../libraries/consul_service'

describe ConsulCookbook::Resource::ConsulService do
  step_into(:consul_service)
  let(:chefspec_options) { {platform: 'windows', version: '2012R2'} }

  context 'with default properties' do
    recipe 'consul::default'

    it { expect(chef_run).to create_directory('C:\Program Files\consul\conf.d') }
    it { is_expected.to create_directory('C:\Program Files\consul\data') }
    it { expect(chef_run).to install_nssm('consul').with(
      program: 'C:\Program Files\consul\consul.exe',
      args: 'agent -config-file="""C:\Program Files\consul\consul.json""" -config-dir="""C:\Program Files\consul\conf.d"""'
    )}
  end
end
