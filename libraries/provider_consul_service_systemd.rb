#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

class Chef::Provider::ConsulServiceSystemd < Chef::Provider::ConsulService
  action :start do
    service 'consul' do
      supports status: true, restart: true, reload: true
      provider Chef::Provider::Service::Init::Systemd
      action [:start, :enable]
    end
  end

  action :stop do
    service 'consul' do
      supports status: true, restart: true, reload: true
      provider Chef::Provider::Service::Init::Systemd
      action :stop
    end
  end

  action :restart do
    service 'consul' do
      supports status: true, restart: true, reload: true
      provider Chef::Provider::Service::Init::Systemd
      action :restart
    end
  end

  action :reload do
    service 'consul' do
      supports status: true, restart: true, reload: true
      provider Chef::Provider::Service::Init::Systemd
      action :reload
    end
  end
end
