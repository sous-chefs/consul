require 'chefspec'
require 'chefspec/berkshelf'
require 'chefspec/cacher'
require 'chef-vault'
require 'poise_boiler/spec_helper'

RSpec.configure do |config|
  config.platform = 'ubuntu'
  config.version = '14.04'

  config.color = true
  config.alias_example_group_to :describe_recipe, type: :recipe
  config.alias_example_group_to :describe_resource, type: :resource

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  Kernel.srand config.seed
  config.order = :random

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end

RSpec.shared_context 'resource tests', type: :resource do

end

RSpec.shared_context 'recipe tests', type: :recipe do
  before do
    stub_command("test -L /usr/local/bin/consul").and_return(true)
    stub_command("/usr/local/go/bin/go version | grep \"go1.4 \"").and_return(true)
  end
end
