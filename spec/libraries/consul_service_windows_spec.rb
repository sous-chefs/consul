require 'spec_helper'
require_relative '../../libraries/consul_service'
require_relative '../../libraries/consul_service_windows'

describe ConsulCookbook::Resource::ConsulService do
  step_into(:consul_service)
  let(:chefspec_options) { { platform: 'windows', version: '2012R2' } }
  let(:shellout) { double('shellout') }

  context 'with default properties' do
    before do
      allow(Mixlib::ShellOut).to receive(:new).and_return(shellout)
      allow(shellout).to receive(:live_stream)
      allow(shellout).to receive(:live_stream=)
      allow(shellout).to receive(:error!)
      allow(shellout).to receive(:stderr)
      allow(shellout).to receive(:run_command)
      allow(shellout).to receive(:exitstatus)
      allow(shellout).to receive(:stdout).and_return("Consul v1.0.7\nProtocol 2 spoken by default, understands 2 to 3 (agent will automatically use protocol >2 when speaking to compatible agents)\n")

      # Stub admin_user method since we are testing a Windows host via Linux
      # Fixed in https://github.com/poise/poise/commit/2f42850c82e295af279d060155bcd5c7ebb31d6a but not released yet
      allow(Poise::Utils::Win32).to receive(:admin_user).and_return('Administrator')
    end

    recipe 'consul::default'

    it do
      is_expected.to create_directory('C:\Program Files\consul\conf.d')
    end

    it do
      is_expected.to create_directory('C:\Program Files\consul\data')
    end

    it do
      expect(chef_run).to install_nssm('consul').with(
        program: 'C:\Program Files\consul\1.0.7\consul.exe',
        args: 'agent -config-file="C:\Program Files\consul\consul.json" -config-dir="C:\Program Files\consul\conf.d"'
      )
    end
  end

  describe 'reload' do
    before do
      default_attributes['consul'] = {
        'config' => config,
      }
    end

    recipe do
      consul_service 'consul' do
        action :reload
      end
    end

    context 'with no ACL token' do
      let(:config) { {} }
      it do
        is_expected.to run_execute('Reload consul').with(
          command: 'consul.exe reload'
        )
      end
    end

    context 'with an ACL token' do
      let(:config) { { 'acl_master_token' => 'my_token' } }
      it do
        is_expected.to run_execute('Reload consul').with(
          command: 'consul.exe reload -token=my_token'
        )
      end
    end
  end
end
