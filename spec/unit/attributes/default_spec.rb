require 'spec_helper'

describe 'consul::default' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe)  }

  context 'sets default attributes' do
    it { expect(chef_run.node.consul.base_url).to eq("https://dl.bintray.com/mitchellh/consul/%{version}.zip") }
    it { expect(chef_run.node.consul.gomaxprocs).to eq(2) }
  end

  describe 'allow override of gomaxprocs' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '12.04') do |node|
        node.set['consul']['gomaxprocs'] = 8
      end.converge(described_recipe)
    end

    it { expect(chef_run.node.consul.gomaxprocs).to eq(8) }
  end
end
