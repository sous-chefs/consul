require 'spec_helper'
require_relative '../../../libraries/consul_installation'
require_relative '../../../libraries/consul_installation_webui'

describe ConsulCookbook::Provider::ConsulInstallationWebui do
  step_into(:consul_installation)
  before { default_attributes['consul'] ||= {} }
  let(:chefspec_options) { {platform: 'ubuntu', version: '14.04'} }

  context 'webui installation' do
    recipe do
      consul_installation '0.6.4' do
        provider :webui
      end
    end

    it do is_expected.to unzip_zipfile('consul_0.6.4_web_ui.zip')
      .with(source: 'https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_web_ui.zip',
            path: '/opt/consul-webui/0.6.4')
    end
  end
end
