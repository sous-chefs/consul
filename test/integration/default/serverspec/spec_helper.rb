require 'serverspec'

set :backend, :exec

RSpec.configure do |c|
  c.path = '/usr/local/bin:/sbin:/bin:/usr/bin'
end
