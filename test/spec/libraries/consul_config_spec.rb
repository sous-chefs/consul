require 'spec_helper'
require_relative '../../../libraries/consul_config'

describe ConsulCookbook::Resource::ConsulConfig do
  step_into(:consul_config)
  let(:chefspec_options) { { platform: 'ubuntu', version: '14.04' } }

  before do
    recipe = double('Chef::Recipe')
    allow_any_instance_of(Chef::RunContext).to receive(:include_recipe).and_return([recipe])
    default_attributes['consul'] = {
      'service_user' => 'consul',
      'service_group' => 'consul',
      'service' => {
        'config_dir' => '/etc/consul/conf.d',
      },
    }
  end

  context 'sets options directly' do
    recipe do
      consul_config '/etc/consul/default.json' do
        owner 'root'
        options do
          recursor 'foo'
          translate_wan_addrs true
        end
      end
    end

    it do
      is_expected.to create_directory('/etc/consul/conf.d')
        .with(user: 'root', group: 'consul', mode: '0755')
    end

    it do
      is_expected.to create_file('/etc/consul/default.json')
        .with(user: 'root', group: 'consul', mode: '0640')
        .with(content: <<-EOH.chomp.gsub(/^        /, ''))
        {
          "recursor": "foo",
          "translate_wan_addrs": true
        }
        EOH
    end
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
