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
      user new_resource.user
      group new_resource.group
      mode '0644'
    end

    # TODO: (jbellone) Write configuration file out as JSON.
    file new_resource.filename do
      user new_resource.user
      group new_resource.path
    end
  end

  action :delete do
    file new_resource.filename do
      action :delete
    end
  end
end
