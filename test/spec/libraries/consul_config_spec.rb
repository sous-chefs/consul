require 'spec_helper'
require_relative '../../../libraries/consul_config'

describe ConsulCookbook::Resource::ConsulConfig do
  step_into(:consul_config)
  let(:chefspec_options) { {platform: 'ubuntu', version: '14.04'} }

  before do
    recipe = double('Chef::Recipe')
    allow_any_instance_of(Chef::RunContext).to receive(:include_recipe).and_return([recipe])
  end

  context 'sets options directly' do
    recipe do
      consul_config '/etc/consul/default.json' do
        options do
          recursor 'foo'
        end
      end
    end

    it { is_expected.to render_file('/etc/consul/default.json').with_content(<<-EOH.chomp) }
{
  "recursor": "foo",
  "verify_incoming": false,
  "verify_outgoing": false
}
EOH
  end

  context 'deletes configuration' do
    recipe do
      consul_config '/etc/consul/default.json' do
        action :delete
      end

      it { is_expected.to delete_file('/etc/consul/default.json') }
    end
  end
end
