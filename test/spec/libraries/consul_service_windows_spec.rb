require 'spec_helper'
require_relative '../../../libraries/consul_service'

describe ConsulCookbook::Resource::ConsulService do
  step_into(:consul_service)
  let(:chefspec_options) { { platform: 'windows', version: '2012R2'} }
  let(:shellout) { double('shellout') }

  context 'with default properties' do
    before do
      Mixlib::ShellOut.stub(:new).and_return(shellout)
      allow(shellout).to receive(:live_stream)
      allow(shellout).to receive(:live_stream=)
      allow(shellout).to receive(:error!)
      allow(shellout).to receive(:stderr)
      allow(shellout).to receive(:run_command)
      allow(shellout).to receive(:stdout).and_return("Consul v0.6.0\nConsul Protocol: 3 (Understands back to: 1)\n")
    end

    recipe 'consul::default'

    it { expect(chef_run).to create_directory('C:\Program Files\consul\conf.d') }
    it { is_expected.to create_directory('C:\Program Files\consul\data') }
    it { expect(chef_run).to install_nssm('consul').with(
      program: 'C:\Program Files\consul\consul.exe',
      args: 'agent -config-file="""C:\Program Files\consul\consul.json""" -config-dir="""C:\Program Files\consul\conf.d"""'
    )}
  end
end
