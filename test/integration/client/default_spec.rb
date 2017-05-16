require_relative '../spec_helper'

consul_executable = "/opt/consul/#{consul_version}/consul"
config_file = '/etc/consul/consul.json'
config_dir = '/etc/consul'

describe file(consul_executable) do
  it { should be_file }
  it { should be_executable }
end

describe group('consul') do
  it { should exist }
end

describe user('consul') do
  it { should exist }
  its('group') { should eq 'consul' }
end

describe command("su - consul -c 'echo successfully logged in'") do
  its(:stdout)      { should_not include 'successfully logged in' }
  its(:exit_status) { should_not eq 0 }
end

describe service('consul') do
  it { should be_enabled }
  it { should be_running }
end

[8500, 8600].each do |p|
  describe port(p) do
    it { should be_listening }
  end
end

describe command("#{consul_executable} members -detailed -token=doublesecret") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should include 'alive' }
  its(:stdout) { should include 'role=node' }
end

describe file('/usr/local/bin/consul') do
  it { should be_symlink }
end

describe file(config_file) do
  it { should be_file }
  its('mode') { should cmp '0640' }
end

describe file(config_dir) do
  it { should be_directory }
  its('mode') { should cmp '0755' }
end
