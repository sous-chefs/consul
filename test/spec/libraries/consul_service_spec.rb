require 'poise_boiler/spec_helper'
require 'poise'

RSpec.configure do |config|
  config.include Halite::SpecHelper
end

require_relative '../../../libraries/consul_service'

describe Chef::Resource::ConsulService do
  step_into(:consul_service)

  context '#action_create' do
    it { run_chef }
  end

  context '#action_enable' do
    it { run_chef }
  end

  context '#action_disable' do
    it { run_chef }
  end

  context '#action_delete' do
    it { run_chef }
  end
end
