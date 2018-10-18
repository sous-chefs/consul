require 'spec_helper'

describe 'consul::default' do
  let(:service_user)        {}
  let(:create_service_user) { true }
  let(:platform)            { { platform: 'ubuntu', version: '14.04' } }

  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(platform) do |node|
      node.normal['consul']['service_user']        = service_user if service_user
      node.normal['consul']['create_service_user'] = create_service_user
    end
    runner.converge(described_recipe)
  end

  context 'with default service_user' do
    it 'creates the user without a login shell' do
      expect(chef_run).to create_poise_service_user('consul')
    end
  end

  context 'with johnny5 service_user' do
    let(:service_user) { 'johnny5' }

    it 'creates the requested user' do
      expect(chef_run).to create_poise_service_user('johnny5')
    end
    it 'does not try to create the default user' do
      expect(chef_run).to_not create_poise_service_user('consul')
    end
  end

  context 'with root service_user' do
    let(:service_user) { 'root' }

    it 'does not try to create the root user' do
      expect(chef_run).to_not create_poise_service_user('root')
    end
    it 'does not try to create the default user' do
      expect(chef_run).to_not create_poise_service_user('consul')
    end
  end

  context 'with create_service_user disabled' do
    let(:create_service_user) { false }

    it 'does not try to create the user' do
      expect(chef_run).to_not create_poise_service_user('consul')
    end
  end

  context 'on Windows' do
    let(:platform) { { platform: 'windows', version: '2012R2' } }

    it 'does not try to create the user' do
      expect(chef_run).to_not create_poise_service_user('consul')
    end
  end
end
