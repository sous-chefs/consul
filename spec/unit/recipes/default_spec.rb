require 'spec_helper'

describe_recipe 'consul::default' do
  it { expect(chef_run).to include_recipe('consul::install_binary') }
  it { expect(chef_run).not_to include_recipe('consul::install_source') }
end
