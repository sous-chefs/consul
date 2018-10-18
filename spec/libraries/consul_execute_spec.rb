require 'spec_helper'
require_relative '../../libraries/consul_execute'

describe ConsulCookbook::Resource::ConsulExecute do
  step_into(:consul_execute)
  let(:chefspec_options) { { platform: 'ubuntu', version: '14.04' } }

  context 'without options' do
    recipe do
      consul_execute 'uptime'
    end
    it { is_expected.to run_execute('/usr/bin/env consul exec uptime') }
  end

  context 'with verbose=true' do
    recipe do
      consul_execute 'uptime' do
        options(verbose: true, service: 'web')
      end
    end
    it { is_expected.to run_execute('/usr/bin/env consul exec -verbose -service=web uptime') }
  end

  context 'with verbose=false' do
    recipe do
      consul_execute 'uptime' do
        options(verbose: false, service: 'web')
      end
    end
    it { is_expected.to run_execute('/usr/bin/env consul exec -service=web uptime') }
  end
end
