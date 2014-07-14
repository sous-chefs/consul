require 'spec_helper'

describe_recipe 'consul::install_source' do
  before do
	stub_command("/usr/local/go/bin/go version | grep \"go1.2 \"").and_return(false)
  end

  it { expect(chef_run).to include_recipe('golang::default') }
  it { expect(chef_run).to create_directory('/opt/go/src/github.com/hashicorp') }
  it { expect(chef_run).to checkout_git('/opt/go/src/github.com/hashicorp/consul') }
  it { expect(chef_run.link('/usr/local/bin/consul')).to link_to('/opt/go/bin/consul') }
  it { expect(chef_run).to include_recipe('consul::_service') }
end
