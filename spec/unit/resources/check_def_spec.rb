require 'spec_helper'
require 'chefspec/berkshelf'

describe_resource "consul_check_def" do
  describe "with id" do
    let(:check_def_path) { "/etc/consul.d/check-uniqueid.json" }

    describe "create" do
      let(:example_recipe) { "consul_spec::check_def_with_id_create" }

      it "removes any check previously registered by name" do
        expect(chef_run).to delete_file("/etc/consul.d/check-dummy name.json")
      end

      it "register the check" do
        ['"name": "dummy name"',
         '"id": "uniqueid"',
         '"script": "curl http://localhost:8888/health"',
         '"http": "http://localhost:8888/health"',
         '"interval": "10s"',
         '"ttl": "50s"',
         '"notes": "Blahblah"'].each do |content|
          expect(chef_run).to render_file(check_def_path)
            .with_content(content)
        end
      end
    end

    describe "delete" do
      let(:example_recipe) { "consul_spec::check_def_with_id_delete" }

      it "de-register the check" do
        expect(chef_run).to delete_file(check_def_path)
      end
    end
  end

  describe "without id" do
    let(:check_def_path) { "/etc/consul.d/check-dummy name.json" }

    describe "create" do
      let(:example_recipe) { "consul_spec::check_def_without_id_create" }

      it "does not remove checks previously registered by name" do
        expect(chef_run).not_to delete_file("/etc/consul.d/check-dummy name.json")
      end

      it "register the check" do
        ['"name": "dummy name"', '"script": "curl http://localhost:8888/health"',
            '"interval": "10s"', '"ttl": "50s"', '"notes": "Blahblah"'].each do |content|
          expect(chef_run).to render_file(check_def_path)
            .with_content(content)
        end
      end
    end

    describe "delete" do
      let(:example_recipe) { "consul_spec::check_def_without_id_delete" }

      it "de-register the check" do
        expect(chef_run).to delete_file(check_def_path)
      end
    end
  end
end
