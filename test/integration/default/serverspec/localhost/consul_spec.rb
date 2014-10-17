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

describe file('/var/lib/consul') do
  it { should be_directory }
end

[8300, 8400, 8500, 8600].each do |p|
  describe port(p) do
    it { should be_listening }
  end
end

describe command 'consul members -detailed' do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match %r{\balive\b} }
  its(:stdout) { should match %r{\brole=consul\b} }
  its(:stdout) { should match %r{\bbootstrap=1\b} }
end

describe 'config file attributes' do
  context command 'consul members -detailed' do
    its(:stdout) { should match %r{\bdc=FortMeade\b} }
  end
end

eth0_ip = command("/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'").stdout.strip
describe command("grep #{eth0_ip} /etc/consul.d/default.json") do
  its(:exit_status) { should eq 0 }
  # bind_addr should only be in the config if node[:consul][:bind_addr] is set
  its(:stdout) { should match %r{"bind_addr":\s"#{eth0_ip}"}}
  its(:stdout) { should match %r{"advertise_addr":\s"#{eth0_ip}"}}
end

describe command('grep encrypt /etc/consul.d/default.json') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match %r{"encrypt":\s"([^\"]*)"} }
end
