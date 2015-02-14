#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

class Chef::Provider::ConsulServiceSysvinit < Chef::Provider::ConsulService
  action :start do
    # TODO: (jbellone) Remove this from provider specific method?
    template "#{new_resource.name} :create /etc/init.d/#{consul_name}" do
      path "/etc/init.d/#{consul_name}"
      source 'sysvinit/consul.sh.erb'
      cookbook 'consul'
      owner 'root'
      group 'root'
      mode '0755'
      variables(
        instance: consul_name,
        envfile_path: parsed_envfile_path
      )
    end

    # TODO: (jbellone) Remove this from provider specific method?
    template "#{new_resource.name} :create #{parsed_envfile_path}" do
      path parsed_envfile_path
      source 'sysvinit/consul.conf.erb'
      cookbook 'consul'
      owner 'root'
      group 'root'
      mode '0644'
      variables(
        instance: consul_name,
        run_user: parsed_run_user,
        run_user: parsed_run_group,
        config_dir: parsed_config_dir
      )
    end

    service "#{new_resource.name} :create #{consul_name}" do
      service_name consul_name
      supports status: true, restart: true, reload: true
      action [:start, :enable]

      subscribes :restart, "file[#{parsed_config_filename}]"
    end
  end

  action :stop do
    service "#{new_resource.name} :stop #{consul_name}" do
      service_name consul_name
      supports status: true, restart: true, reload: true
      action [:stop, :disable]
    end
  end

  action :restart do
    service "#{new_resource.name} :restart #{consul_name}" do
      service_name consul_name
      supports status: true, restart: true, reload: true
      action :restart
    end
  end

  action :reload do
    service "#{new_resource.name} :reload #{consul_name}" do
      service_name consul_name
      supports status: true, restart: true, reload: true
      action :reload
    end
  end
end
