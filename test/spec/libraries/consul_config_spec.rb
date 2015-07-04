require 'poise_boiler/spec_helper'
require 'poise'

RSpec.configure do |config|
  config.include Halite::SpecHelper
end

require_relative '../../../libraries/consul_config'

describe Chef::Resource::ConsulConfig do
  step_into(:consul_config)

  context 'with defaults' do
    recipe do
      consul_config '/etc/consul/default.json' do
        bag_name 'secrets'
        bag_item 'vault'
      end
    end

    before do
      recipe = double("Chef::Recipe")
      allow_any_instance_of(Chef::RunContext).to receive(:include_recipe).and_return([recipe])
    end

    it { is_expected.to create_directory('/etc/consul') }
    it { is_expected.to create_file('/etc/consul/default.json') }
    it { run_chef }
  end
end
