require 'spec_helper'

describe_recipe 'consul::ui' do
  it { expect(chef_run).to include_recipe('ark::default') }
end
