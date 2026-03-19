# frozen_string_literal: true

require 'spec_helper'

describe 'consul_execute' do
  step_into :consul_execute
  platform 'ubuntu', '24.04'

  context 'runs a command' do
    recipe do
      consul_execute 'uptime'
    end

    it { is_expected.to run_consul_execute('uptime') }
  end

  context 'runs a command with options' do
    recipe do
      consul_execute 'uptime' do
        options(service: 'api')
      end
    end

    it { is_expected.to run_consul_execute('uptime') }
  end
end
