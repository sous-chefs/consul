require 'poise_boiler/spec_helper'
require 'poise'

RSpec.configure do |config|
  config.include Halite::SpecHelper
end

require_relative '../../../libraries/consul_watch'

describe Chef::Resource::ConsulWatch do
  step_into(:consul_watch)

  context '#action_create' do
    before do
      # TODO: (jbellone) Stub out the execute bits.
    end

    recipe do
      consul_watch 'foobar' do

      end
    end

    it do
      is_expected.to run_execute()
    end

    it { run_chef }
  end

  context '#action_delete' do
    before do
      # TODO: (jbellone) Stub out the execute bits.
    end

    recipe do
      consul_watch 'foobar' do
        action :delete
      end
    end

    it do
      is_expected.to run_execute()
    end

    it { run_chef }
  end
end
