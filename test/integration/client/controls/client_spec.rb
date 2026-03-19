# frozen_string_literal: true

title 'Client Suite - Consul Client'

config_file = '/etc/consul/consul.json'
config_dir  = '/etc/consul'

control 'consul-client-install-01' do
  impact 1.0
  title 'Consul binary is installed'

  describe command('consul version') do
    its(:exit_status) { should eq 0 }
  end
end

control 'consul-client-user-01' do
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

control 'consul-client-service-01' do
  impact 1.0
  title 'Consul service is running'

  describe service('consul') do
    it { should be_enabled }
    it { should be_running }
  end
end

control 'consul-client-ports-01' do
  impact 1.0
  title 'Consul client ports are listening'

  [8500, 8600].each do |p|
    describe port(p) do
      it { should be_listening }
    end
  end
end

control 'consul-client-cluster-01' do
  impact 1.0
  title 'Consul client is alive'

  describe command('consul members') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should include 'alive' }
    its(:stdout) { should include 'client' }
  end
end

control 'consul-client-config-01' do
  impact 1.0
  title 'Consul configuration files have correct permissions'

  describe file(config_file) do
    it { should be_file }
    its('mode') { should cmp '0640' }
  end

  describe file(config_dir) do
    it { should be_directory }
    its('mode') { should cmp '0755' }
  end
end
