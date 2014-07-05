require 'spec_helper'

describe_recipe 'consul::install_binary' do
  it { expect(chef_run).to include_recipe('golang::default') }
  it { expect(chef_run).to create_directory("#{node[:golang][:gohome]}/src/github.com/hashicorp") }
  it { expect(chef_run).to checkout_git('https://github.com/hashicorp/consul.git') }
  it { expect(chef_run.link('/usr/bin/local/consul')).to link_to('/opt/go/bin') }
  it { expect(chef_run).to include_recipe('consul::_service') }
end
