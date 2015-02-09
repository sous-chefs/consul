#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

class Chef::Provider::ConsulClient < Chef::Provider::LWRPBase
  use_inline_resources if defined?(use_inline_resources)

  def whyrun_supported?
    true
  end

  action :create do
  end

  action :delete do
  end
end
