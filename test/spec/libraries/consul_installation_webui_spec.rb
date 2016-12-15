require 'spec_helper'
require_relative '../../../libraries/consul_installation'
require_relative '../../../libraries/consul_installation_webui'

describe ConsulCookbook::Provider::ConsulInstallationWebui do
  step_into(:consul_installation)
  before { default_attributes['consul'] ||= {} }
  let(:chefspec_options) { {platform: 'ubuntu', version: '14.04'} }

  context 'webui installation' do
    recipe do
      consul_installation '0.7.1' do
        provider :webui
      end
    end

    it do
      is_expected.to create_directory('/opt/consul-webui/0.7.1')
      .with(
        recursive: true
      )
    end

    it do
      is_expected.to create_directory('/var/lib/consul')
      .with(
        recursive: true
      )
    end

    it do
      is_expected.to unpack_poise_archive('https://releases.hashicorp.com/consul/0.7.1/consul_0.7.1_web_ui.zip').with(
        destination: '/opt/consul-webui/0.7.1',
        merged_source_properties: {'checksum' => '1b793c60e1af24cc470421d0411e13748f451b51d8a6ed5fcabc8d00bfb84264' }
      )
    end
  end
end
