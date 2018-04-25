require 'spec_helper'
require_relative '../../../libraries/consul_config_v1'

describe ConsulCookbook::Resource::ConsulConfigV1 do
  # We have to specify the class here, because `poise_boiler/spec_helper` can't
  # resolve providers with node attributes
  step_into(ConsulCookbook::Resource::ConsulConfigV1)
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
      'version' => '1.0',
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
    end

    it { is_expected.to delete_file('/etc/consul/default.json') }
  end

  describe 'parameters' do
    let(:config) { JSON.parse(subject.find_resource('consul_config', '/etc/consul/default.json').params_to_json) }

    context 'no retry_join parameters' do
      describe 'retry_join_ec2' do
        recipe do
          consul_config '/etc/consul/default.json' do
            retry_join_ec2(
              'region'            => 'ca-central-1',
              'tag_key'           => 'foo',
              'tag_value'         => 'bar',
              'access_key_id'     => 'KEY_ID',
              'secret_access_key' => 'SECRETS'
            )
          end
        end
        it 'sets the `retry_join` field' do
          expect(
            config['retry_join'].collect do |item|
              Hash[item.split.map { |pair| pair.split('=') }]
            end
          ).to contain_exactly(
            'provider'          => 'aws',
            'region'            => 'ca-central-1',
            'tag_key'           => 'foo',
            'tag_value'         => 'bar',
            'access_key_id'     => 'KEY_ID',
            'secret_access_key' => 'SECRETS'
          )
        end
        it 'does not set the `retry_join_ec2` field' do
          expect(config['retry_join_ec2']).to be_nil
        end
        it 'logs a warning' do
          expect(Chef::Log).to receive(:warn).with('Parameter \'retry_join_ec2\' is deprecated')
          chef_run
        end
      end
      describe 'retry_join_azure' do
        recipe do
          consul_config '/etc/consul/default.json' do
            retry_join_azure(
              'tag_name'          => 'foo',
              'tag_value'         => 'bar',
              'subscription_id' => 'SUBSCRIPTION_ID',
              'tenant_id' => 'TENANT_ID',
              'client_id' => 'CLIENT_ID',
              'secret_access_key' => 'SECRETS'
            )
          end
        end
        it 'sets the `retry_join` field' do
          expect(
            config['retry_join'].collect do |item|
              Hash[item.split.map { |pair| pair.split('=') }]
            end
          ).to contain_exactly(
            'provider'          => 'azure',
            'tag_name'          => 'foo',
            'tag_value'         => 'bar',
            'subscription_id' => 'SUBSCRIPTION_ID',
            'tenant_id' => 'TENANT_ID',
            'client_id' => 'CLIENT_ID',
            'secret_access_key' => 'SECRETS'
          )
        end
        it 'does not set the `retry_join_azure` field' do
          expect(config['retry_join_azure']).to be_nil
        end
        it 'logs a warning' do
          expect(Chef::Log).to receive(:warn).with('Parameter \'retry_join_azure\' is deprecated')
          chef_run
        end
      end
    end

    context 'with another retry_join parameter' do
      describe 'retry_join_ec2' do
        recipe do
          consul_config '/etc/consul/default.json' do
            retry_join ['127.0.0.1']
            retry_join_ec2(
              'region'    => 'ca-central-1',
              'tag_key'   => 'foo',
              'tag_value' => 'bar'
            )
          end
        end
        it 'sets the `retry_join` field' do
          expect(
            config['retry_join'].collect do |item|
              Hash[item.split.map { |pair| pair.split('=') }]
            end
          ).to contain_exactly(
            { '127.0.0.1' => nil },
            { # rubocop:disable Style/BracesAroundHashParameters
              'provider'  => 'aws',
              'region'    => 'ca-central-1',
              'tag_key'   => 'foo',
              'tag_value' => 'bar',
            }
          )
        end
      end
      describe 'retry_join_azure' do
        recipe do
          consul_config '/etc/consul/default.json' do
            retry_join ['127.0.0.1']
            retry_join_azure(
              'tag_name'  => 'foo',
              'tag_value' => 'bar'
            )
          end
        end
        it 'sets the `retry_join` field' do
          expect(
            config['retry_join'].collect do |item|
              Hash[item.split.map { |pair| pair.split('=') }]
            end
          ).to contain_exactly(
            { '127.0.0.1' => nil },
            { # rubocop:disable Style/BracesAroundHashParameters
              'provider'  => 'azure',
              'tag_name'  => 'foo',
              'tag_value' => 'bar',
            }
          )
        end
      end
    end
  end
end
