require_relative '../spec_helper'

consul_executable = "C:\\Program\ Files\\consul\\#{consul_version}\\consul.exe"
consul_command    = "& '#{consul_executable}'"

config_file = 'C:\Program Files\consul\consul.json'
confd_dir   = 'C:\Program Files\consul\conf.d'
data_dir    = 'C:\Program Files\consul\data'

describe file(consul_executable) do
  it { should be_file }
end

describe service('consul') do
  it { should be_enabled }
  it { should be_running }
end

[8300, 8400, 8500, 8600].each do |p|
  describe port(p) do
    it { should be_listening }
  end
end

describe command("#{consul_command} members -detailed") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should include 'alive' }
  its(:stdout) { should include 'role=consul' }
  its(:stdout) { should include 'bootstrap=1' }
  its(:stdout) { should include 'dc=fortmeade' }
end

describe file(config_file) do
  it { should be_file }
end

describe directory(confd_dir) do
  it { should be_directory }
end

describe directory(data_dir) do
  it { should be_directory }
end

describe file("#{confd_dir}\\consul_definition_check.json") do
  it { should be_file }
end

describe file("#{confd_dir}\\consul_watch_check.json") do
  it { should be_file }
end
