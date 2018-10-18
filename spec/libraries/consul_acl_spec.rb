require 'spec_helper'
require 'webmock/rspec'
require 'diplomat'
require_relative '../../libraries/consul_acl'

describe ConsulCookbook::Resource::ConsulAcl do
  step_into(:consul_acl)
  let(:chefspec_options) { { platform: 'ubuntu', version: '14.04' } }

  context 'when the Consul agent is not ready' do
    let(:info_body) do
      [
        {
          'CreateIndex' => 3,
          'ModifyIndex' => 3,
          'ID' => 'client_token',
          'Name' => 'Client Token',
          'Type' => 'client',
          'Rules' => {
            'service' => {
              '' => {
                'policy' => 'write',
              },
            },
          },
        },
      ]
    end
    before do
      json = JSON.generate(info_body.first)
      stub_request(:get, %r{/v1/acl/info/})
        .to_return(body: 'No cluster leader', status: 500).then
        .to_return(body: json, status: 200)
      stub_request(:put, %r{/v1/acl/create})
        .to_return(body: json, status: 200)
    end

    recipe do
      consul_acl 'client_token' do
        acl_name 'Client Token'
        type 'client'
        auth_token 'ABC123'
      end
    end

    it do
      expect { chef_run }.to_not raise_error
    end
  end
end
