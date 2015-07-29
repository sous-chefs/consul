require 'spec_helper'

describe_recipe 'consul::default' do
  cached(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  context 'with default attributes' do
    it { expect(chef_run).to include_recipe('selinux::permissive') }
    it { expect(chef_run).to create_poise_service_user('consul').with(group: 'consul') }
    it { expect(chef_run).to create_consul_config('consul').with(path: '/etc/consul.json') }
    it { expect(chef_run).to create_consul_service('consul').with(config_file: '/etc/consul.json') }
    it { expect(chef_run).to enable_consul_service('consul').with(config_file: '/etc/consul.json') }

    it { expect(chef_run).to_not include_recipe('firewall::default') }
    it { expect(chef_run).to_not allow_firewall_rule('consul') }

    it 'converges successfully' do
      chef_run
    end
  end

  context "with node['firewall']['allow_consul'] = true" do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set['firewall']['allow_consul'] = true
      end.converge(described_recipe)
    end

    it { expect(chef_run).to include_recipe('firewall::default') }
    it { expect(chef_run).to allow_firewall_rule('consul').with(protocol: :tcp, port: [8600, 8500, 8400, 8301, 8302, 8300]) }

    it 'converges successfully' do
      chef_run
    end
  end
end
