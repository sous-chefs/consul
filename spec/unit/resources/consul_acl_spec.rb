# frozen_string_literal: true

require 'spec_helper'

# Diplomat-based resources are not stepped into because they require
# the diplomat gem at converge time. We test resource declaration only.
describe 'consul_acl' do
  platform 'ubuntu', '24.04'

  context 'creates an ACL' do
    recipe do
      consul_acl 'test-acl' do
        auth_token 'master-token'
        acl_name 'Test ACL'
        type 'client'
        rules 'key "" { policy = "read" }'
      end
    end

    it { is_expected.to create_consul_acl('test-acl') }
  end

  context 'deletes an ACL' do
    recipe do
      consul_acl 'test-acl' do
        auth_token 'master-token'
        action :delete
      end
    end

    it { is_expected.to delete_consul_acl('test-acl') }
  end
end
