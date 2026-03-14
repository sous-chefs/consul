# frozen_string_literal: true

require 'spec_helper'

# Diplomat-based resources are not stepped into because they require
# the diplomat gem at converge time. We test resource declaration only.
describe 'consul_token' do
  platform 'ubuntu', '24.04'

  context 'creates a token' do
    recipe do
      consul_token 'test-token' do
        auth_token 'master-token'
        policies %w(global-management)
      end
    end

    it { is_expected.to create_consul_token('test-token') }
  end

  context 'deletes a token' do
    recipe do
      consul_token 'test-token' do
        auth_token 'master-token'
        action :delete
      end
    end

    it { is_expected.to delete_consul_token('test-token') }
  end
end
