require 'spec_helper'
require_relative '../../../libraries/consul_installation'
require_relative '../../../libraries/consul_installation_webui'

describe ConsulCookbook::Provider::ConsulInstallationWebui do
  step_into(:consul_installation)
  before { default_attributes['consul'] ||= {} }
  let(:chefspec_options) { {platform: 'ubuntu', version: '14.04'} }

  context 'webui installation' do
    pending('replace with poise-archive')

    recipe do
      consul_installation '0.7.0' do
        provider :webui
      end
    end

    it do is_expected.to create_directory('/opt/consul-webui/0.7.0')
      .with(
        recursive: true
      )
    end

    it do is_expected.to create_directory('/var/lib/consul')
      .with(
        recursive: true
      )
    end

    it do is_expected.to unzip_zipfile('consul_0.7.0_web_ui.zip')
      .with(
        source: 'https://releases.hashicorp.com/consul/0.7.0/consul_0.7.0_web_ui.zip'
      )
    end
  end
end
