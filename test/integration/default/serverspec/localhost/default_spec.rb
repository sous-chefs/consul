require 'spec_helper'

describe file('/srv/consul/current/consul') do
  it { should be_file }
  it { should be_executable }
end

describe file('/usr/local/bin/consul') do
  it { should be_symlink }
  it { should be_linked_to '/srv/consul/current/consul' }
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

describe command('/usr/local/bin/consul members -detailed') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match %r{\balive\b} }
  its(:stdout) { should match %r{\brole=consul\b} }
  its(:stdout) { should match %r{\bbootstrap=1\b} }
  its(:stdout) { should match %r{\bdc=fortmeade\b} }
end
