require 'spec_helper'
require_relative '../../libraries/consul_config_v0'

shared_examples 'a simple field' do |field_name, field_value|
  it "sets `#{field_name}`" do
    expect(config[field_name]).to eq field_value
  end
end

describe ConsulCookbook::Resource::ConsulConfigV0 do
  # We have to specify the class here, because `poise_boiler/spec_helper` can't
  # resolve providers with node attributes
  step_into(ConsulCookbook::Resource::ConsulConfigV0)
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
      'version' => '0.9.3',
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
      it 'sets the `retry_join_ec2` field' do
        expect(config['retry_join_ec2']).to include(
          'region'            => 'ca-central-1',
          'tag_key'           => 'foo',
          'tag_value'         => 'bar',
          'access_key_id'     => 'KEY_ID',
          'secret_access_key' => 'SECRETS'
        )
      end
    end

    describe 'retry_join_azure' do
      recipe do
        consul_config '/etc/consul/default.json' do
          retry_join_azure(
            'tag_name'          => 'foo',
            'tag_value'         => 'bar',
            'subscription_id'   => 'SUBSCRIPTION_ID',
            'tenant_id'         => 'TENANT_ID',
            'client_id'         => 'CLIENT_ID',
            'secret_access_key' => 'SECRETS'
          )
        end
      end
      it 'sets the `retry_join_azure` field' do
        expect(config['retry_join_azure']).to include(
          'tag_name'          => 'foo',
          'tag_value'         => 'bar',
          'subscription_id'   => 'SUBSCRIPTION_ID',
          'tenant_id'         => 'TENANT_ID',
          'client_id'         => 'CLIENT_ID',
          'secret_access_key' => 'SECRETS'
        )
      end
    end

    describe 'atlas_infrastructure' do
      recipe do
        consul_config '/etc/consul/default.json' do
          atlas_infrastructure 'infra'
        end
      end
      it_should_behave_like 'a simple field', 'atlas_infrastructure', 'infra'
    end
    describe 'atlas_token' do
      recipe do
        consul_config '/etc/consul/default.json' do
          atlas_token 'token'
        end
      end
      it_should_behave_like 'a simple field', 'atlas_token', 'token'
    end
    describe 'atlas_acl_token' do
      recipe do
        consul_config '/etc/consul/default.json' do
          atlas_acl_token 'acl_token'
        end
      end
      it_should_behave_like 'a simple field', 'atlas_acl_token', 'acl_token'
    end
    describe 'atlas_join' do
      recipe do
        consul_config '/etc/consul/default.json' do
          atlas_join true
        end
      end
      it_should_behave_like 'a simple field', 'atlas_join', true
    end
    describe 'atlas_endpoint' do
      recipe do
        consul_config '/etc/consul/default.json' do
          atlas_endpoint 'endpoint'
        end
      end
      it_should_behave_like 'a simple field', 'atlas_endpoint', 'endpoint'
    end

    describe 'http_api_response_headers' do
      recipe do
        consul_config '/etc/consul/default.json' do
          http_api_response_headers(
            'Access-Control-Allow-Origin' => '*'
          )
        end
      end
      it 'sets the `http_api_response_headers` field' do
        expect(config['http_api_response_headers']).to include(
          'Access-Control-Allow-Origin' => '*'
        )
      end
    end

    describe 'recursor' do
      recipe do
        consul_config '/etc/consul/default.json' do
          recursor '127.0.0.1'
        end
      end
      it_should_behave_like 'a simple field', 'recursor', '127.0.0.1'
    end

    describe 'statsd_addr' do
      recipe do
        consul_config '/etc/consul/default.json' do
          statsd_addr '127.0.0.1:123'
        end
      end
      it_should_behave_like 'a simple field', 'statsd_addr', '127.0.0.1:123'
    end

    describe 'statsite_addr' do
      recipe do
        consul_config '/etc/consul/default.json' do
          statsite_addr '127.0.0.1:123'
        end
      end
      it_should_behave_like 'a simple field', 'statsite_addr', '127.0.0.1:123'
    end

    describe 'statsite_prefix' do
      recipe do
        consul_config '/etc/consul/default.json' do
          statsite_prefix 'prefix'
        end
      end
      it_should_behave_like 'a simple field', 'statsite_prefix', 'prefix'
    end

    describe 'discovery_max_stale_unsupported_old_version' do
      before do
        recipe = double('Chef::Recipe')
        allow_any_instance_of(Chef::RunContext).to receive(:include_recipe).and_return([recipe])
      end
      recipe do
        consul_config '/etc/consul/default.json' do
          discovery_max_stale '72h'
        end
      end
      it 'does not set the [`discovery_max_stale`] field since unsupported' do
        expect(config['discovery_max_stale']).to be_nil
      end
    end
  end
end
