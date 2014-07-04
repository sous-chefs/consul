require 'chefspec'
require 'chefspec/berkshelf'
require 'chefspec/cacher'
require 'chefspec/server'
require File.expand_path('../support/matchers', __FILE__)

RSpec.configure do |config|
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

at_exit { ChefSpec::Coverage.report! }
