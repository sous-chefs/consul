require 'spec_helper'

describe file('/var/lib/consul/ui/index.html') do
  it { should be_file }
end

describe command('wget -q -O- http://0.0.0.0:8500/ui/index.html') do
  it { should return_exit_status 0 }
  its(:stdout) { should == File.read('/var/lib/consul/ui/index.html') }
end
