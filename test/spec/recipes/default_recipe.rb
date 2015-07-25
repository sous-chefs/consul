require 'spec_helper'

describe_recipe 'consul::default' do
  cached(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  context 'with default attributes' do
    it { expect(chef_run).to include_recipe('selinux::permissive') }
    it { expect(chef_run).to create_poise_service_user('consul').with(group: 'consul') }
    it { expect(chef_run).to create_consul_config('/etc/consul.json') }
    it { expect(chef_run).to enable_consul_service('consul').with(config_file: '/etc/consul.json') }

    it 'converges successfully' do
      chef_run
    end
  end
end
