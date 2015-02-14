#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

class Chef::Provider::ConsulServiceUpstart < Chef::Provider::ConsulService
  action :start do
    # TODO: (jbellone) Remove this from provider specific method?
    template "#{new_resource.name} :create /etc/init/#{consul_name}.conf" do
      path "/etc/init/#{consul_name}.conf"
      source 'upstart/consul.conf.erb'
      cookbook 'consul'
      mode '0644'
      variables(
        instance: consul_name,
        run_user: parsed_run_user,
        run_group: parsed_run_group,
        config_dir: parsed_config_dir
      )
    end

    service "#{new_resource.name} :start #{consul_name}" do
      service_name consul_name
      supports status: true, restart: true, reload: true
      provider Chef::Provider::Service::Upstart
      action [:start, :enable]

      subscribes :restart, "file[#{parsed_config_filename}]"
    end
  end

  action :stop do
    service "#{new_resource.name} :stop #{consul_name}" do
      service_name consul_name
      supports status: true, restart: true, reload: true
      provider Chef::Provider::Service::Upstart
      action [:stop, :disable]
    end
  end

  action :restart do
    service "#{new_resource.name} :restart #{consul_name}" do
      service_name consul_name
      supports status: true, restart: true, reload: true
      provider Chef::Provider::Service::Upstart
      action :restart
    end
  end

  action :reload do
    service "#{new_resource.name} :reload #{consul_name}" do
      service_name consul_name
      supports status: true, restart: true, reload: true
      provider Chef::Provider::Service::Upstart
      action :reload
    end
  end
end
