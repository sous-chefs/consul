#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

class Chef::Provider::ConsulServiceSystemd < Chef::Provider::ConsulService
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

  action :create do
    template "/etc/conf.d/#{new_resource.service_name}" do
      source 'consul-sysconfig.erb'
      mode '0755'
    end

    template "/etc/systemd/system/#{new_resource.service_name}.service" do
      source 'consul-unit.conf.erb'
      mode '0755'
      variables(
        run_user: new_resource.run_user,
        run_group: new_resource.run_group,
        etc_config_dir: new_resource.etc_config_dir,
        config_dir: new_resource.config_dir,
        service_name: new_resource.service_name
      )
    end
  end

  action :remove do
    file "/etc/conf.d/#{new_resource.service_name}" do
      action :delete
    end

    file "/etc/systemd/system/#{new_resource.service_name}.service" do
      action :delete
    end
  end
end
