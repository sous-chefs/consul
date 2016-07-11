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

    it do is_expected.to create_directory('/opt/consul-webui/0.6.4')
      .with(
        recursive: true
      )
    end

    it do is_expected.to create_directory('/var/lib/consul')
      .with(
        recursive: true
      )
    end

    it do is_expected.to unzip_zipfile('consul_0.6.4_web_ui.zip')
      .with(
        checksum: '5f8841b51e0e3e2eb1f1dc66a47310ae42b0448e77df14c83bb49e0e0d5fa4b7',
        path: '/opt/consul-webui/0.6.4',
        source: 'https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_web_ui.zip'
      )
    end
  end
end
