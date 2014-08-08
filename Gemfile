source 'https://rubygems.org'
gem 'berkshelf'
gem 'rake'
gem 'rspec'
gem 'rubocop'
gem 'foodcritic'
gem 'tailor'
gem 'coveralls', require: false

group :test, :integration do
  gem 'chefspec', git: 'git@github.com:sethvargo/chefspec.git', ref: '40fb48b2011ec1342db01068a3c8b993b9cd8088'
  gem 'test-kitchen'
  gem 'kitchen-vagrant'
  gem 'serverspec'
end
