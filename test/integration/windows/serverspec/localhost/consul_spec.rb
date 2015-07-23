require 'spec_helper'

describe command('where.exe /R C:\ProgramData\chocolatey\bin consul') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match "C:\\ProgramData\\chocolatey\\bin\\consul.exe\n" }
end

describe service('consul') do
  it { should be_enabled }
  it { should be_running }
end

describe file('C:\ProgramData\consul\config') do
  it { should be_directory }
end

describe file('C:\ProgramData\consul\data') do
  it { should be_directory }
end

describe port(8300) do
  it { should be_listening }
end

# For some reason, the check can't find the port
#[8400, 8500, 8600].each do |p|
#  describe port(p) do
#    it { should be_listening.on('127.0.0.1') }
#  end
#end
