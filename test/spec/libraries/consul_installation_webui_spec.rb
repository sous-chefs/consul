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

    it do is_expected.to unpack_poise_archive('https://releases.hashicorp.com/consul/0.7.0/consul_0.7.0_web_ui.zip')
      .with(
        checksum: '42212089c228a73a0881a5835079c8df58a4f31b5060a3b4ffd4c2497abe3aa8',
        extract_to: '/opt/consul-webui'
      )
    end
  end
end
