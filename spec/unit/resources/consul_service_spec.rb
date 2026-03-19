# frozen_string_literal: true

require 'spec_helper'

describe 'consul_service' do
  step_into :consul_service
  platform 'ubuntu', '24.04'

  context 'action :enable' do
    recipe do
      consul_service 'consul' do
        action :enable
      end
    end

    it { is_expected.to create_directory('/var/lib/consul').with(owner: 'consul', group: 'consul', mode: '0750') }
    it { is_expected.to create_systemd_unit('consul.service') }
    it { is_expected.to enable_systemd_unit('consul.service') }
  end

  context 'action :enable with custom systemd_params' do
    recipe do
      consul_service 'consul' do
        systemd_params('LimitNOFILE' => 9001)
        action :enable
      end
    end

    it { is_expected.to create_systemd_unit('consul.service') }
  end

  context 'action :start' do
    recipe do
      consul_service 'consul' do
        action :start
      end
    end

    it { is_expected.to start_service('consul') }
  end

  context 'action :stop' do
    recipe do
      consul_service 'consul' do
        action :stop
      end
    end

    it { is_expected.to stop_service('consul') }
  end

  context 'action :reload' do
    recipe do
      consul_service 'consul' do
        action :reload
      end
    end

    it { is_expected.to reload_service('consul') }
  end

  context 'action :restart' do
    recipe do
      consul_service 'consul' do
        action :restart
      end
    end

    it { is_expected.to restart_service('consul') }
  end

  context 'action :disable' do
    recipe do
      consul_service 'consul' do
        action :disable
      end
    end

    it { is_expected.to stop_service('consul') }
    it { is_expected.to disable_systemd_unit('consul.service') }
    it { is_expected.to delete_systemd_unit('consul.service') }
  end
end
