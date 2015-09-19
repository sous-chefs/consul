require 'spec_helper'
require_relative '../../../libraries/consul_config'

describe ConsulCookbook::Resource::ConsulConfig do
  step_into(:consul_config)
  let(:chefspec_options) { {platform: 'ubuntu', version: '14.04'} }

  before do
    recipe = double('Chef::Recipe')
    allow_any_instance_of(Chef::RunContext).to receive(:include_recipe).and_return([recipe])
    allow_any_instance_of(Chef::Provider).to receive(:chef_vault_item) { { 'ca_certificate' => 'foo', 'certificate' => 'bar', 'private_key' => 'baz' }  }
  end

  context 'sets options directly' do
    recipe do
      consul_config '/etc/consul/default.json' do
        options do
          recursor 'foo'
        end
      end
    end

    it { is_expected.to render_file('/etc/consul/default.json').with_content(<<-EOH.chomp) }
{
  "recursor": "foo",
  "verify_incoming": false,
  "verify_outgoing": false
}
EOH
  end

  context 'manages certificates' do
    recipe do
      consul_config '/etc/consul/default.json' do
        key_file '/etc/consul/ssl/private/consul.key'
        ca_file '/etc/consul/ssl/CA/ca.crt'
        cert_file '/etc/consul/ssl/certs/consul.crt'
        verify_incoming true
        verify_outgoing true
      end
    end

    it { is_expected.to create_directory('/etc/consul/ssl/CA') }
    it { is_expected.to create_directory('/etc/consul/ssl/certs') }
    it { is_expected.to create_directory('/etc/consul/ssl/private') }

    it do
      is_expected.to create_file('/etc/consul/ssl/CA/ca.crt')
      .with(content: 'foo')
      .with(owner: 'consul')
      .with(group: 'consul')
      .with(mode: '0644')
    end

    it do
      is_expected.to create_file('/etc/consul/ssl/certs/consul.crt')
      .with(content: 'bar')
      .with(owner: 'consul')
      .with(group: 'consul')
      .with(mode: '0644')
    end

    it do
      is_expected.to create_file('/etc/consul/ssl/private/consul.key')
      .with(content: 'baz')
      .with(sensitive: true)
      .with(owner: 'consul')
      .with(group: 'consul')
      .with(mode: '0640')
    end

    it { is_expected.to create_directory('/etc/consul') }
    it { is_expected.to create_file('/etc/consul/default.json') }
  end

  context 'deletes configuration' do
    recipe do
      consul_config '/etc/consul/default.json' do
        action :delete
      end

      it { is_expected.to delete_file('/etc/consul/default.json') }
    end
  end
end
