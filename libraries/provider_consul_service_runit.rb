#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

class Chef::Provider::ConsulServiceSystemd < Chef::Provider::ConsulService
  include ConsulCookbook::Helpers::Runit

  action :start do
    runit_service "#{new_resource.name} :create #{consul_name}" do
      service_name consul_name
      supports status: true, restart: true, reload: true
      action [:start, :enable]

      subscribes :restart, "file[#{parsed_config_filename}]"
    end

    service consul_name do
      supports status: true, restart: true, reload: true
      reload_command runit_reload_command
    end
  end

  action :stop do
    runit_service "#{new_resource.name} :stop #{consul_name}" do
      service_name consul_name
      supports status: true, restart: true, reload: true
      action [:stop, :disable]
    end
  end

  action :restart do
    runit_service "#{new_resource.name} :restart #{consul_name}" do
      service_name consul_name
      supports status: true, restart: true, reload: true
      action :restart
    end
  end

  action :reload do
    runit_service "#{new_resource.name} :reload #{consul_name}" do
      service_name consul_name
      supports status: true, restart: true, reload: true
      action :reload
    end
  end
end
