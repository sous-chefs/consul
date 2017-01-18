require_relative '../spec_helper'

consul_version = '0.7.1'

unless windows?
  describe file("/opt/consul-webui/#{consul_version}/base.css") do
    it { should be_file }
  end

  describe command('curl -X GET http://127.0.0.1:8500/ui/') do
    its(:stdout) { should match /Consul by HashiCorp/ }
  end
end
