require 'spec_helper'

describe_recipe 'consul::default' do
  it { expect(chef_run).to include_recipe('consul::install_binary') }
  it { expect(chef_run).not_to include_recipe('consul::install_source') }
  it { expect(chef_run).to include_recipe('consul::_service') }

  context %Q(sets node['consul']['install_method'] = 'source') do
    let(:chef_run) do
      ChefSpec::Runner.new(node_attributes) do |node|
        node.override['consul']['install_method'] = 'source'
      end.converge(described_recipe)
    end
  end
end
