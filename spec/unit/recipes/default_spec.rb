require 'spec_helper'

describe 'consul::default' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }

  it { expect(chef_run).to include_recipe('consul::install_binary') }
  it { expect(chef_run).not_to include_recipe('consul::install_source') }
end
