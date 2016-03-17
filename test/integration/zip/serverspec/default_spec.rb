require 'spec_helper'

describe file('C:\opt\consul\0.6.4\consul.exe') do
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

describe command('& "C:\opt\consul\0.6.4\consul.exe" members -detailed') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match %r{\balive\b} }
  its(:stdout) { should match %r{\brole=consul\b} }
  its(:stdout) { should match %r{\bbootstrap=1\b} }
  its(:stdout) { should match %r{\bdc=fortmeade\b} }
end

config_file = 'C:\Program Files\consul\consul.json'
config_dir  = 'C:\Program Files\consul\conf.d'
data_dir    = 'C:\Program Files\consul\data'

describe file(config_file) do
  it { should be_file }
end

describe file(config_dir) do
  it { should be_directory }
end

describe file(data_dir) do
  it { should be_directory }
end

describe file('C:\foo\bar\out.log') do
  it { should be_file }
end

describe file('C:\foo\bar\err.log') do
  it { should be_file }
end
