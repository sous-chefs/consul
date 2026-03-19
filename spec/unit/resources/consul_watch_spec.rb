# frozen_string_literal: true

require 'spec_helper'

describe 'consul_watch' do
  step_into :consul_watch
  platform 'ubuntu', '24.04'

  context 'creates a watch' do
    recipe do
      consul_watch 'app-deploy' do
        type 'event'
        parameters(handler: '/usr/local/bin/clear-disk-cache.sh')
      end
    end

    it { is_expected.to create_directory('/etc/consul/conf.d').with(owner: 'consul', group: 'consul', mode: '0755') }
    it { is_expected.to create_file('/etc/consul/conf.d/app-deploy.json').with(owner: 'consul', group: 'consul', mode: '0640') }
  end

  context 'action :delete' do
    recipe do
      consul_watch 'app-deploy' do
        type 'event'
        action :delete
      end
    end

    it { is_expected.to delete_file('/etc/consul/conf.d/app-deploy.json') }
  end
end
