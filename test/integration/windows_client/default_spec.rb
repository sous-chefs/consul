require_relative '../spec_helper'

consul_root = 'C:\Program Files\consul'

consul_executable = File.join(consul_root, consul_version, 'consul.exe')
consul_command    = "& '#{consul_executable}'"

config_file = 'C:\Program Files\consul\consul.json'
config_dir  = 'C:\Program Files\consul\conf.d'

describe file(consul_executable) do
  it { should be_file }
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

# Symlink creation disabled
# symlink_path = File.join(consul_root, 'consul.exe')
# describe file(symlink_path) do
#   it { should be_file }
# end
# Because we can't use be_symlink for Windows
# describe command("(Get-Item \"#{symlink_path}\").Attributes -match 'ReparsePoint'") do
#   its(:exit_status)   { should eq 0      }
#   its('stdout.strip') { should eq 'True' }
# end

# Commented out, because reloading the path doesn't get picked up on the first run
# describe os_env('PATH') do
#   its('split') { should include consul_root }
# end

describe command("#{consul_command} members -detailed -token=doublesecret") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should include 'alive' }
  its(:stdout) { should include 'role=node' }
end

describe file(config_file) do
  it { should be_file }
end

describe file(config_dir) do
  it { should be_directory }
end
