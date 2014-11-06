require 'spec_helper'
require 'chefspec/berkshelf'

describe_resource "consul_key_watch_def" do
  let(:service_def_path) { "/etc/consul.d/key-watch-dummy.json" }

  describe "create" do
    let(:example_recipe) { "consul_spec::key_watch_create" }

    it "register the service" do
      ['"key": "/key/path"', '"type": "key"',
        '"handler": "chef-client"'].each do |content|
        expect(chef_run).to render_file(service_def_path)
          .with_content(content)
      end
    end
  end

  describe "delete" do
    let(:example_recipe) { "consul_spec::key_watch_delete" }

    it "de-register the service" do
      expect(chef_run).to delete_file(service_def_path)
      expect(chef_run.file(service_def_path))
    end
  end
end
