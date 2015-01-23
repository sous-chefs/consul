require 'rspec/core/rake_task'
require 'stove/rake_task'

Stove::RakeTask.new

RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

task default: :spec
