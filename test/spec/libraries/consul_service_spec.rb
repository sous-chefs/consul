require 'spec_helper'

describe_recipe 'consul::default' do
  context 'with default attributes' do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new(step_into: %w{consul_service}) do |node, server|
        server.create_data_bag('secrets', {
          'consul' => {
            'ca_certificate' => 'foo',
            'certificate' => 'bar',
            'private_key' => 'baz'
          }
        })
      end.converge(described_recipe)
    end

    it { expect(chef_run).to create_libartifact_file('consul-0.5.2') }
    it { expect(chef_run).to create_link('/usr/local/bin/consul').with(to: '/srv/consul/0.5.2/consul') }

    it 'converges successfully' do
      chef_run
    end
  end

  context "with node['consul']['service']['install_method'] = 'source'" do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new(step_into: %w{consul_service}) do |node, server|
        server.create_data_bag('secrets', {
          'consul' => {
            'ca_certificate' => 'foo',
            'certificate' => 'bar',
            'private_key' => 'baz'
          }
        })

        node.set['consul']['service']['install_method'] = 'source'
      end.converge(described_recipe)
    end

    it { expect(chef_run).to include_recipe('golang::default') }
    it { expect(chef_run).to create_directory('/srv/consul/src') }
    it { expect(chef_run).to checkout_git('/srv/consul/src/consul-0.5.2') }
    it { expect(chef_run).to create_link('/usr/local/bin/consul').with(to: '/srv/consul/0.5.2/consul') }

    it 'converges successfully' do
      chef_run
    end
  end

  context "with node['consul']['service']['install_method'] = 'package'" do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new(step_into: %w{consul_service}) do |node, server|
        server.create_data_bag('secrets', {
          'consul' => {
            'ca_certificate' => 'foo',
            'certificate' => 'bar',
            'private_key' => 'baz'
          }
        })

        node.set['consul']['service']['install_method'] = 'package'
      end.converge(described_recipe)
    end

    it { expect(chef_run).to install_package('consul') }

    it 'converges successfully' do
      chef_run
    end
  end
end
