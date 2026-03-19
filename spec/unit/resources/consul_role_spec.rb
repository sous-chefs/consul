# frozen_string_literal: true

require 'spec_helper'

# Diplomat-based resources are not stepped into because they require
# the diplomat gem at converge time. We test resource declaration only.
describe 'consul_role' do
  platform 'ubuntu', '24.04'

  context 'creates a role' do
    recipe do
      consul_role 'test-role' do
        auth_token 'master-token'
        description 'Test role'
        policies [{ 'ID' => 'abc123' }]
      end
    end

    it { is_expected.to create_consul_role('test-role') }
  end

  context 'deletes a role' do
    recipe do
      consul_role 'test-role' do
        auth_token 'master-token'
        action :delete
      end
    end

    it { is_expected.to delete_consul_role('test-role') }
  end
end
