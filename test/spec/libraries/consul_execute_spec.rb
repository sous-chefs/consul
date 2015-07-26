require 'poise_boiler/spec_helper'
require_relative '../../../libraries/consul_execute'

describe ConsulCookbook::Resource::ConsulExecute do
  step_into(:consul_execute)
  context 'without options' do
    recipe do
      consul_execute 'uptime'
    end
    it { is_expected.to run_execute('/usr/bin/env consul exec uptime') }
  end

  context 'with verbose=true' do
    recipe do
      consul_execute 'uptime' do
        options(verbose: true)
      end
    end
    it { is_expected.to run_execute('/usr/bin/env consul exec -verbose uptime') }
  end

  context 'with verbose=false' do
    recipe do
      consul_execute 'uptime' do
        options(verbose: false)
      end
    end
    it { is_expected.to run_execute('/usr/bin/env consul exec uptime') }
  end
end
