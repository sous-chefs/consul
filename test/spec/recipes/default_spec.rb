require 'spec_helper'

describe 'consul::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end
  end

  context 'When selinux is set to be permissive, on a RHEL distribution' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node, server|
        node.automatic['os'] = 'linux'
        node.automatic['platform_family'] = 'rhel'
        node.set['selinux']['state'] = 'permissive'
      end.converge(described_recipe)
    end

    it 'selinux_state action is permissive' do
      expect(chef_run).to permissive_selinux_state('SELinux Permissive')
    end
  end

  context 'When selinux is set to be disabled, on a RHEL distribution' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node, server|
        node.automatic['os'] = 'linux'
        node.automatic['platform_family'] = 'rhel'
        node.set['selinux']['state'] = 'disabled'
      end.converge(described_recipe)
    end

    it 'selinux_state action is disabled' do
      expect(chef_run).to disabled_selinux_state('SELinux Disabled')
    end
  end

  context 'When selinux is set to be enforcing, on a RHEL distribution' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node, server|
        node.automatic['os'] = 'linux'
        node.automatic['platform_family'] = 'rhel'
        node.set['selinux']['state'] = 'enforcing'
      end.converge(described_recipe)
    end

    it 'selinux_state action is enforcing' do
      expect(chef_run).to enforcing_selinux_state('SELinux Enforcing')
    end
  end
end
