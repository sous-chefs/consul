require 'spec_helper'
require 'chefspec/berkshelf'

describe_resource "consul_service_def" do
  let(:service_def_path) { "/etc/consul.d/service-uniqueid.json" }

  describe "create" do
    let(:example_recipe) { "consul_spec::service_def_create" }

    it "register the service" do
      ['"name": "dummy"', '"port": 8888',
        '"script": "curl http://localhost:8888/health"'].each do |content|
        expect(chef_run).to render_file(service_def_path)
          .with_content(content)

        expect(chef_run.file(service_def_path))
          .to notify('service[consul]').to(:reload).delayed
      end
    end
  end

  describe "delete" do
    let(:example_recipe) { "consul_spec::service_def_delete" }

    it "de-register the service" do
      expect(chef_run).to delete_file(service_def_path)
      expect(chef_run.file(service_def_path))
        .to notify('service[consul]').to(:reload).delayed
    end
  end
end
