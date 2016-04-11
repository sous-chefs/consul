source 'https://rubygems.org'
gem 'poise', '~> 2.2'
gem 'poise-service', '~> 1.0'
gem 'poise-boiler'

group :lint do
  gem 'rubocop'
  gem 'foodcritic'
end

group :unit, :integration do
  gem 'chef-sugar'
  gem 'chefspec'
  gem 'berkshelf'
  gem 'test-kitchen'
  gem 'serverspec'
end

group :development do
  gem 'awesome_print'
  gem 'rake'
  gem 'stove'
end

group :doc do
  gem 'yard'
end

group :faraday do
  # Referencing https://github.com/nomad/shenzhen/issues/96 to fix build issue regarding
  # the faraday gem
  gem 'faraday', '~> 8.0'
end
