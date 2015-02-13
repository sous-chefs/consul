#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

class Chef::Provider::ConsulService < Chef::Provider::LWRPBase
  use_inline_resources if defined?(use_inline_resources)

  def whyrun_supported?
    true
  end

  action :create do
    template new_resource.etc_config_dir do
      source 'consul-sysconfig.erb'
      mode '0755'
      variables()
    end
  end

  action :remove do
    file new_resource.etc_config_dir do
      action :delete
    end
  end
end
