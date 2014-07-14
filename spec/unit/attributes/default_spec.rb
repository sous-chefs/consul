require 'spec_helper'

describe 'consul::default' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }

  context 'sets default attributes' do
    it { expect(chef_run.node.consul.base_url).to eq('https://dl.bintray.com/mitchellh/consul/') }
  end
end
