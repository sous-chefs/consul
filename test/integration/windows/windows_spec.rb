require_relative '../spec_helper'

consul_root       = 'C:\Program Files\consul'

consul_executable = File.join(consul_root, consul_version, 'consul.exe')
symlink_path      = File.join(consul_root, 'consul.exe')
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

[8300, 8500, 53].each do |p|
  describe port(p) do
    it { should be_listening }
  end
end

describe command("#{consul_command} members -detailed -token=doublesecret") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should include 'alive' }
  its(:stdout) { should include 'role=consul' }
  its(:stdout) { should include 'bootstrap=1' }
  its(:stdout) { should include 'dc=fortmeade' }
end

describe file(symlink_path) do
  it { should be_file }
end
# Because we can't use be_symlink for Windows
describe command("(Get-Item \"#{symlink_path}\").Attributes -match 'ReparsePoint'") do
  its(:exit_status)   { should eq 0      }
  its('stdout.strip') { should eq 'True' }
end

# Commented out, because reloading the path doesn't get picked up on the first run
# describe os_env('PATH') do
#   its('split') { should include consul_root }
# end

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
