#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

class Chef::Provider::ConsulServiceSystemd < Chef::Provider::ConsulService
  action :start do
    runit_service new_resource.service_name do
      supports status: true, restart: true, reload: true
      action :start
    end
  end

  action :stop do
    runit_service new_resource.service_name do
      supports status: true, restart: true, reload: true
      action :stop
    end
  end

  action :restart do
    runit_service new_resource.service_name do
      supports status: true, restart: true, reload: true
      action :restart
    end
  end

  action :reload do
    runit_service new_resource.service_name do
      supports status: true, restart: true, reload: true
      action :reload
      reload_command %Q(#{node['runit']['sv_bin']} hup #{new_resource.service_name})
    end
  end
end
