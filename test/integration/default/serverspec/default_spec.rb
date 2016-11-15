require 'spec_helper'

consul_version = '0.7.1'

if windows?
  consul_executable = "C:\\Program Files\\consul\\#{consul_version}\\consul.exe"
  consul_command    = "& '#{consul_executable}'"
else
  consul_executable = "/opt/consul/#{consul_version}/consul"
  consul_command    = consul_executable
end

describe file(consul_executable) do
  it { should be_file }
  it { should be_executable } unless windows?
end

unless windows?
  describe group('consul') do
    it { should exist  }
  end

  describe user('consul') do
    it { should exist }
    it { should belong_to_group('consul') }
  end

  describe command("su - consul -c 'echo successfully logged in'") do
    its(:stdout)      { should_not match /successfully logged in/ }
    its(:exit_status) { should_not eq 0 }
  end
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
  its(:stdout) { should match %r{\balive\b} }
  its(:stdout) { should match %r{\brole=consul\b} }
  its(:stdout) { should match %r{\bbootstrap=1\b} }
  its(:stdout) { should match %r{\bdc=fortmeade\b} }
end

unless windows?
  config_dir  = '/etc/consul'

  describe file(config_dir) do
    it { should be_directory }
    it { should be_owned_by     'root' }
    it { should be_grouped_into 'consul' }
    it { should be_mode 755 }
  end

  describe file('/usr/local/bin/consul') do
    it { should be_symlink }
  end
end

if windows?
  config_file = 'C:\Program Files\consul\consul.json'
  confd_dir   = 'C:\Program Files\consul\conf.d'
  data_dir    = 'C:\Program Files\consul\data'
else
  config_file = '/etc/consul/consul.json'
  confd_dir   = '/etc/consul/conf.d'
  data_dir    = '/var/lib/consul'
end

describe file(config_file) do
  it { should be_file }
  unless windows?
    it { should be_owned_by     'root' }
    it { should be_grouped_into 'consul' }
    it { should be_mode 640 }
  end
end

describe file(confd_dir) do
  it { should be_directory }
  unless windows?
    it { should be_owned_by     'root' }
    it { should be_grouped_into 'consul' }
    it { should be_mode 755 }
  end
end

describe file(data_dir) do
  it { should be_directory }
  unless windows?
    it { should be_owned_by     'consul' }
    it { should be_grouped_into 'consul' }
    it { should be_mode 750 }
  end
end

describe file("#{confd_dir}/consul_definition_check.json") do
  it { should be_file }
  unless windows?
    it { should be_owned_by     'root' }
    it { should be_grouped_into 'consul' }
    it { should be_mode 640 }
  end
end

describe file("#{confd_dir}/consul_watch_check.json") do
  it { should be_file }
  unless windows?
    it { should be_owned_by     'root' }
    it { should be_grouped_into 'consul' }
    it { should be_mode 640 }
  end
end
