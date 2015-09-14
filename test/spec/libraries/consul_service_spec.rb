require 'spec_helper'
require_relative '../../../libraries/consul_service'

describe ConsulCookbook::Resource::ConsulService do
  step_into(:consul_service)
  context 'with default properties' do
    recipe do
      consul_service 'consul' do
        version '0.5.2'
      end
    end

    it { expect(chef_run).to create_directory('/etc/consul') }
    it { is_expected.to create_directory('/var/lib/consul') }
  end
end
