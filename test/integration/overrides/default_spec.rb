require_relative '../spec_helper'

consul_executable = "/opt/consul/#{consul_version}/consul"
symlink_path      = '/usr/local/bin/consul'
consul_command    = symlink_path

config_file = '/etc/consul/consul.json'
confd_dir   = '/etc/consul/conf.d'
data_dir    = '/var/lib/consul'

svc_manager = if command('systemctl --help').exit_status == 0
                :systemd
              elsif os.name == 'ubuntu'
                :upstart
              else
                :sysv
              end

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

describe send("#{svc_manager}_service", 'consul') do
  it { should be_enabled }
  it { should be_running }
end

[8300, 8500, 8600].each do |p|
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
  it { should be_symlink }
end

describe file(config_file) do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'consul' }
  its('mode') { should cmp '0640' }
end

describe file(confd_dir) do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'consul' }
  its('mode') { should cmp '0755' }
end

describe directory(data_dir) do
  it { should be_directory }
  it { should be_owned_by 'consul' }
  it { should be_grouped_into 'consul' }
  its('mode') { should cmp '0750' }
end

describe file("#{confd_dir}/consul_definition_check.json") do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'consul' }
  its('mode') { should cmp '0644' }
end

describe file("#{confd_dir}/consul_watch_check.json") do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'consul' }
  its('mode') { should cmp '0640' }
end

case svc_manager
when :systemd
  describe file('/etc/systemd/system/consul.service') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0644' }
    its('content') { should include 'LimitNOFILE=2048' }
  end
when :upstart
  describe file('/etc/init/consul.conf') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0644' }
    its('content') { should include 'limit nofile 2048 2048' }
  end
when :sysv
  describe file('/etc/init.d/consul') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0755' }
    its('content') { should include 'ulimit -n 2048' }
  end
end

pid = processes('consul agent').pids.first

describe file("/proc/#{pid}/limits") do
  its(:content) { should match(/^Max open files\W+2048\W+2048\W+files\W+$/) }
end
