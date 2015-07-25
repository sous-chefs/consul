require 'poise_boiler/spec_helper'
require 'poise'

RSpec.configure do |config|
  config.include Halite::SpecHelper
end

require_relative '../../../libraries/consul_definition'

describe ConsulCookbook::Resource::ConsulDefinition do
  step_into(:consul_definition)

  context '#action_create' do
    recipe do
      consul_definition '/etc/consul/default.json' do
      end
    end

    it do
      is_expected.to create_file()
    end

    it { run_chef }
  end

  context '#action_create' do
    recipe do
      consul_definition '/etc/consul/default.json' do
        action :delete
      end
    end

    it do
      is_expected.to delete_file()
    end

    it { run_chef }
  end

end
