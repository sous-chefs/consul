#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

class Chef::Provider::ConsulConfig < Chef::Provider::LWRPBase
  use_inline_resources if defined?(use_inline_resources)

  def whyrun_supported?
    true
  end

  action :create do
    directory new_resource.path do
      owner new_resource.run_user
      group new_resource.run_group
      mode '0644'
    end

    # TODO: (jbellone) Figure out a better way to generate this set of
    # options. Right now this is a bit messy. Especially if options
    # are added after the fact.
    invalid_options = [:path, :run_user, :run_group]
    configuration = new_resource.to_hash.reject { |k, v| invalid_options.include?(k) }
    file new_resource.filename do
      owner new_resource.run_user
      group new_resource.run_group
      content JSON.parse(configuration.to_json)
    end
  end

  action :delete do
    file new_resource.filename do
      action :delete
    end
  end
end
