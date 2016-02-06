require 'spec_helper'

describe file('C:\Program Files\consul\consul.exe') do
  it { should be_file }
end

describe service('consul') do
  it { should be_enabled }
  it { should be_running }
end

[8301, 8400, 8500, 8600].each do |p|
  describe port(p) do
    it { should be_listening }
  end
end

describe command('& "C:\Program Files\consul\consul.exe" members -detailed') do
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
#  it { should be_owned_by     'consul' }
#  it { should be_grouped_into 'consul' }
  
#  it { should be_mode 640 }
end

describe file(config_dir) do
  it { should be_directory }
#  it { should be_owned_by     'consul' }
#  it { should be_grouped_into 'consul' }
  
#  it { should be_mode 755 }
end

describe file(data_dir) do
  it { should be_directory }
#  it { should be_owned_by     'consul' }
#  it { should be_grouped_into 'consul' }
  
#  it { should be_mode 755 }
end
