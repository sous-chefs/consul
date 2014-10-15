require 'spec_helper'

describe file('/var/lib/consul/ui/index.html') do
  it { should be_file }
end

eth0_ip = command("/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'").stdout.strip
describe command("wget -q -O- http://#{eth0_ip}:8500/ui/index.html") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should eq File.read('/var/lib/consul/ui/index.html') }
end
