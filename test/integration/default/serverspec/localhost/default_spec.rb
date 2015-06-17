require 'spec_helper'

describe command('which consul') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match '/usr/local/bin/consul' }
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

describe command 'consul members -detailed' do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match %r{\balive\b} }
  its(:stdout) { should match %r{\brole=consul\b} }
  its(:stdout) { should match %r{\bbootstrap=1\b} }
end

describe 'config file attributes' do
  context command 'consul members -detailed' do
    its(:stdout) { should match %r{\bdc=FortMeade\b}i }
  end
end
