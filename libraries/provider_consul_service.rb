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
    user "#{new_resource.name} :create #{parsed_run_user}" do
      system true
      home '/dev/null'
      shell '/bin/false'
      username parsed_run_user
      not_if { username == 'root' }
    end

    group "#{new_resource.name} :create #{parsed_run_group}" do
      system true
      members parsed_run_user
      group_name parsed_run_group
      not_if { group_name == 'root' }
    end

    directory "#{new_resource.name} :create /var/lib/#{consul_name}" do
      owner parsed_run_user
      group parsed_run_group
      mode '0744'
    end
  end

  action :delete do
  end
end
