require 'spec_helper'

describe_recipe 'consul::ui' do
  it { expect(chef_run).to include_recipe('ark::default') }
  it do
    expect(chef_run).to put_ark('consul_ui')
      .with(path: '/var/lib/consul/ui')
      .with(version: '0.4.0')
  end
end
