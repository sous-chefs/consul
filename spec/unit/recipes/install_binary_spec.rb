require 'spec_helper'

describe_recipe 'consul::install_binary' do
  it { expect(chef_run).to include_recipe('ark') }
  it { expect(chef_run).to include_recipe('consul::_service') }
  #it { expect(chef_run).to dump_ark('consul') }
end
