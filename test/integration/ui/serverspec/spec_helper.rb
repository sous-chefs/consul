begin
  require 'rspec/its'
rescue LoadError
  require 'rubygems/dependency_installer'
  Gem::DependencyInstaller.new.install('rspec-its')
  require 'rspec/its'
end

require 'serverspec'

include SpecInfra::Helper::Exec
include SpecInfra::Helper::DetectOS

RSpec.configure do |c|
  c.path = '/usr/local/bin:/sbin:/bin:/usr/bin'
end
