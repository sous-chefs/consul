require 'spec_helper'

consul_version = '0.6.4'
consul_executable = "/opt/consul/#{consul_version}/consul"

describe file(consul_executable) do
  it { should be_file }
  it { should be_executable }
end

describe group('consul') do
  it { should exist  }
end

describe user('consul') do
  it { should exist }
  it { should belong_to_group('consul') }
  it { should have_login_shell('/bin/bash') }
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

describe command('/opt/consul/0.6.4/consul members -detailed') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match %r{\balive\b} }
  its(:stdout) { should match %r{\brole=consul\b} }
  its(:stdout) { should match %r{\bbootstrap=1\b} }
  its(:stdout) { should match %r{\bdc=fortmeade\b} }
end

config_file = '/etc/consul/consul.json'
config_dir  = '/etc/consul/conf.d'
data_dir    = '/var/lib/consul'

describe file(config_file) do
  it { should be_file }
  it { should be_owned_by     'consul' }
  it { should be_grouped_into 'consul' }

  it { should be_mode 640 }
end

describe file(config_dir) do
  it { should be_directory }
  it { should be_owned_by     'consul' }
  it { should be_grouped_into 'consul' }

  it { should be_mode 755 }
end

describe file(data_dir) do
  it { should be_directory }
  it { should be_owned_by     'consul' }
  it { should be_grouped_into 'consul' }

  it { should be_mode 755 }
end

if os[:family] == 'ubuntu'
  describe file('/etc/init/consul.conf' ) do
    its(:content) do
      should include(<<-EOT)
post-start script
  while ! #{consul_executable} info ; sleep 1; done
end script
      EOT
    end
  end
end