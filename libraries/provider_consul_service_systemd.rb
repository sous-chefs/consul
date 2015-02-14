#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

class Chef::Provider::ConsulServiceSystemd < Chef::Provider::ConsulService
  action :start do
    directory "#{new_resource.name} :create /run/#{consul_name}" do
      path "/run/#{consul_name}"
      owner 'root'
      group 'root'
      mode '0755'
      recursive true
    end

    # TODO: (jbellone) Remove this from provider specific method?
    template "#{new_resource.name} :create /etc/conf.d/#{consul_name}" do
      path "/etc/conf.d/#{consul_name}"
      source 'systemd/consul.conf.erb'
      owner 'root'
      group 'root'
      mode '0644'
      cookbook 'consul'
      variables(
        service_name: consul_name,
        run_user: parsed_run_user,
        run_group: parsed_run_group
      )
    end

    # TODO: (jbellone) Remove this from provider specific method?
    template "#{new_resource.name} :create /usr/lib/systemd/system/#{consul_name}.service" do
      path "/usr/lib/systemd/system/#{consul_name}.service"
      source 'systemd/consul.service.erb'
      owner 'root'
      group 'root'
      mode '0644'
      cookbook 'consul'
      variables(
        service_name: consul_name,
        run_user: parsed_run_user,
        run_group: parsed_run_group,
        config_dir: parsed_config_dir
      )
    end

    directory "#{new_resource.name} :create /usr/lib/systemd/system/#{consul_name}.service.d" do
      path "/usr/lib/systemd/system/#{consul_name}.service.d"
      owner 'root'
      group 'root'
      mode '0755'
      recursive true
    end

    service "#{new_resource.name} :create #{consul_name}" do
      service_name consul_name
      supports status: true, restart: true, reload: true
      provider Chef::Provider::Service::Init::Systemd
      action [:start, :enable]

      subscribes :restart, "file[#{parsed_config_filename}]"
    end
  end

  action :stop do
    service "#{new_resource.name} :stop #{consul_name}" do
      service_name consul_name
      supports status: true, restart: true, reload: true
      provider Chef::Provider::Service::Init::Systemd
      action [:stop, :disable]
    end
  end

  action :restart do
    service "#{new_resource.name} :restart #{consul_name}" do
      service_name consul_name
      supports status: true, restart: true, reload: true
      provider Chef::Provider::Service::Init::Systemd
      action :restart
    end
  end

  action :reload do
    service "#{new_resource.name} :reload #{consul_name}" do
      service_name consul_name
      supports status: true, restart: true, reload: true
      provider Chef::Provider::Service::Init::Systemd
      action :reload
    end
  end
end
