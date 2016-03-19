require 'spec_helper'
require_relative '../../../libraries/consul_installation'

describe ConsulCookbook::Resource::ConsulInstallation do
  step_into(:consul_installation)
  let(:chefspec_options) { {platform: 'ubuntu', version: '14.04'} }

  context 'consul ui install' do
    recipe 'consul_spec::consul_installation_webui'

    it do is_expected.to unzip_zipfile('consul_0.6.4_web_ui.zip')
      .with(owner: 'myconsul',
            group: 'myconsul',
            remote_url: 'https://releases.hashicorp.com/consul/0.5.1/consul_0.5.1_web_ui.zip',
            install_path: '/opt')
    end
  end
end
