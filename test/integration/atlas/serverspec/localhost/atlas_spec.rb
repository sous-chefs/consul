require 'spec_helper'

describe command('which consul') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match '/usr/local/bin/consul' }
end

describe service('consul') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/consul.d') do
  it { should be_directory }
end

describe command('grep atlas /etc/consul.d/default.json') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match %r{"atlas_infrastructure":\s"([^"]*)"} }
  its(:stdout) { should match %r{"atlas_join":\s(true|false)} }
  its(:stdout) { should match %r{"atlas_token":\s"([^"]*)"} }
end
