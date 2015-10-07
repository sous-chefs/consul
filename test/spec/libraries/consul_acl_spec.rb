require 'spec_helper'
require_relative '../../../libraries/consul_acl'

describe ConsulCookbook::Resource::ConsulACL do
  step_into(:consul_acl)
  let(:chefspec_options) { {platform: 'ubuntu', version: '14.04'} }

  context 'acl definition' do
    recipe do
      consul_acl 'my-team-token' do
        rules ({'service' => { 'our-team-services' => 'write' }}.to_json)
      end
    end

    it { is_expected.to run_ruby_block('my-team-token') }
  end
end
