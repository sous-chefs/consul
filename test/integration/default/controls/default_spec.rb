# frozen_string_literal: true

title 'Default Suite - Consul Server'

config_file = '/etc/consul/consul.json'
confd_dir   = '/etc/consul/conf.d'
data_dir    = '/var/lib/consul'

control 'consul-install-01' do
  impact 1.0
  title 'Consul binary is installed'

  describe command('consul version') do
    its(:exit_status) { should eq 0 }
  end
end

control 'consul-user-01' do
  impact 1.0
  title 'Consul user and group exist'

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
end

control 'consul-service-01' do
  impact 1.0
  title 'Consul service is running'

  describe service('consul') do
    it { should be_enabled }
    it { should be_running }
  end
end

control 'consul-ports-01' do
  impact 1.0
  title 'Consul ports are listening'

  [8300, 8500, 8600].each do |p|
    describe port(p) do
      it { should be_listening }
    end
  end
end

control 'consul-cluster-01' do
  impact 1.0
  title 'Consul cluster is healthy'

  describe command('consul members -detailed -token=doublesecret') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should include 'alive' }
    its(:stdout) { should include 'role=consul' }
    its(:stdout) { should include 'bootstrap=1' }
    its(:stdout) { should include 'dc=fortmeade' }
  end
end

control 'consul-config-01' do
  impact 1.0
  title 'Consul configuration files have correct permissions'

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
end

control 'consul-data-01' do
  impact 0.7
  title 'Consul data directory has correct permissions'

  describe directory(data_dir) do
    it { should be_directory }
    it { should be_owned_by 'consul' }
    it { should be_grouped_into 'consul' }
    its('mode') { should cmp '0750' }
  end
end

control 'consul-systemd-01' do
  impact 0.7
  title 'Consul systemd unit has custom parameters'

  describe command('grep files /proc/$(pgrep consul)/limits') do
    its(:stdout) { should include '9001' }
  end
end
