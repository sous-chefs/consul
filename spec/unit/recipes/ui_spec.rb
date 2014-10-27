require 'spec_helper'

describe_recipe 'consul::ui' do
  it { expect(chef_run).to include_recipe('ark::default') }
  it do
    expect(chef_run).to install_ark('consul_ui')
      .with(path: '/var/lib/consul')
      .with(home_dir: '/var/lib/consul/ui')
      .with(version: '0.4.1')
  end
end
