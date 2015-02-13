#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

class Chef::Provider::ConsulServiceSystemd < Chef::Provider::ConsulService
  action :create do
    # TODO: (jbellone) Create unit file for system service.
  end

  action :remove do
    # TODO: (jbellone) Delete unit file for system service.
  end

  action :start do
    service new_resource.service_name do
      supports status: true, restart: true, reload: true
      provider Chef::Provider::Service::Init::Systemd
      action [:start, :enable]
    end
  end

  action :stop do
    service new_resource.service_name do
      supports status: true, restart: true, reload: true
      provider Chef::Provider::Service::Init::Systemd
      action :stop
    end
  end

  action :restart do
    service new_resource.service_name do
      supports status: true, restart: true, reload: true
      provider Chef::Provider::Service::Init::Systemd
      action :restart
    end
  end

  action :reload do
    service new_resource.service_name do
      supports status: true, restart: true, reload: true
      provider Chef::Provider::Service::Init::Systemd
      action :reload
    end
  end
end
