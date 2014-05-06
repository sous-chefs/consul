require 'serverspec'

include SpecInfra::Helper::Exec
include SpecInfra::Helper::DetectOS

RSpec.configure do |c|
  c.path = '/usr/local/bin:/sbin:/bin:/usr/bin'
end
