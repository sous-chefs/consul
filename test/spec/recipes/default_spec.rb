require 'spec_helper'

describe "consul::default" do

  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  context "with default service_user" do
    it 'creates the user without a login shell' do
      expect(chef_run).to create_poise_service_user('consul')
    end
  end

  context "with root service_user" do
    before do
      default_attributes['consul'] ||= {}
      default_attributes['consul']['service_user'] = 'root'
    end

    it 'does not try to create the root user' do
      expect(chef_run).to_not create_poise_service_user('root')
    end
  end

  context "with create_service_user disabled" do
    before do
      default_attributes['consul'] ||= {}
      default_attributes['consul']['create_service_user'] = false
    end

    it 'does not try to create the user' do
      expect(chef_run).to_not create_poise_service_user('consul')
    end
  end
end
