# frozen_string_literal: true

require 'spec_helper'

# Diplomat-based resources are not stepped into because they require
# the diplomat gem at converge time. We test resource declaration only.
describe 'consul_policy' do
  platform 'ubuntu', '24.04'

  context 'creates a policy' do
    recipe do
      consul_policy 'test-policy' do
        auth_token 'master-token'
        description 'Test policy'
        rules 'key "" { policy = "read" }'
      end
    end

    it { is_expected.to create_consul_policy('test-policy') }
  end

  context 'deletes a policy' do
    recipe do
      consul_policy 'test-policy' do
        auth_token 'master-token'
        action :delete
      end
    end

    it { is_expected.to delete_consul_policy('test-policy') }
  end
end
