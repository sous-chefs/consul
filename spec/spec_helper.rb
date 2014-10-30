require 'chefspec'
require 'chefspec/berkshelf'
require 'chefspec/cacher'
require 'chefspec/server'
require 'coveralls'

require_relative 'support/matchers'

Coveralls.wear!

RSpec.configure do |config|
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

at_exit { ChefSpec::Coverage.report! }

RSpec.shared_context 'recipe tests', type: :recipe do
  let(:chef_run) { ChefSpec::Runner.new(node_attributes).converge(described_recipe) }

  def node_attributes
    {
     platform: 'ubuntu',
     version: '12.04'
    }
  end
end

RSpec.shared_context "resource tests", type: :resource do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(node_attributes.merge(step_into)).converge(example_recipe)
  end

  let(:example_recipe) do
    fail %(
Please specify the name of the test recipe that executes your recipe:

    let(:example_recipe) do
      "consul_spec::service_def"
    end

)
  end

  let(:node) { chef_run.node }

  def node_attributes
    {
     platform: 'ubuntu',
     version: '12.04'
    }
  end

  let(:step_into) do
    { step_into: [cookbook_name] }
  end

  def cookbook_recipe_names
    described_recipe.split("::", 2)
  end

  def cookbook_name
    cookbook_recipe_names.first
  end

  def recipe_name
    cookbook_recipe_names.last
  end
end
