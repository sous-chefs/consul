unified_mode true

property :config_file, String, default: lazy { node['consul']['config']['path'] }
property :user, String, default: lazy { node['consul']['service_user'] }
property :group, String, default: lazy { node['consul']['service_group'] }
property :environment, Hash, default: lazy { default_environment }
property :data_dir, String, default: lazy { node['consul']['config']['data_dir'] }
property :config_dir, String, default: lazy { node['consul']['config_dir'] }
property :nssm_params, Hash, default: lazy { node['consul']['service']['nssm_params'] }
property :systemd_params, Hash, default: lazy { node['consul']['service']['systemd_params'] }
property :program, String, default: '/usr/local/bin/consul'
property :acl_token, String, default: lazy { node['consul']['config']['acl_master_token'] }
property :restart_on_update, [true, false], default: true

def shell_environment
  shell = node['consul']['service_shell']
  shell.nil? ? {} : { 'SHELL' => shell }
end

def default_environment
  {
    'GOMAXPROCS' => [node['cpu']['total'], 2].max.to_s,
    'PATH' => '/usr/local/bin:/usr/bin:/bin',
  }.merge(shell_environment)
end

action_class do
  include ConsulCookbook::Helpers
end

action :enable do
  directory new_resource.data_dir do
    recursive true
    owner new_resource.user
    group new_resource.group
    mode '0750'
  end

  systemd_unit 'consul.service' do
    content(
      Unit: {
        Description: 'consul',
        Wants: 'network.target',
        After: 'network.target',
      },
      Service: {
        Environment: new_resource.environment.map { |key, val| %("#{key}=#{val}") }.join(' '),
        ExecStart: command(new_resource.program, new_resource.config_file, new_resource.config_dir),
        ExecReload: '/bin/kill -HUP $MAINPID',
        KillSignal: 'TERM',
        User: new_resource.user,
        WorkingDirectory: new_resource.data_dir,
      }.merge(new_resource.systemd_params),
      Install: {
        WantedBy: 'multi-user.target',
      }
    )
    notifies :restart, 'service[consul]' if new_resource.restart_on_update
    action %i(create enable)
  end

  service 'consul' do
    action :nothing
  end
end

action :start do
  service 'consul' do
    action :start
  end
end

action :reload do
  service 'consul' do
    action :reload
  end
end

action :restart do
  service 'consul' do
    action :restart
  end
end

action :disable do
  service 'consul' do
    action :stop
  end

  systemd_unit 'consul.service' do
    action %i(disable delete)
  end
end

action :stop do
  service 'consul' do
    action :stop
  end
end
