require 'spec_helper'

describe_recipe 'consul::install_binary' do
  it { expect(chef_run).to include_recipe('ark::default') }
  #it { expect(chef_run).to dump_ark('consul') }
end
