unified_mode true

# @!property config_file
# @return [String]
property :config_file, kind_of: String, default: lazy { node['consul']['config']['path'] }
# @!property user
# The service user the Consul process runs as.
# @return [String]
property :user, kind_of: String, default: lazy { node['consul']['service_user'] }
# @!property group
# The service group the Consul process runs as.
# @return [String]
property :group, kind_of: String, default: lazy { node['consul']['service_group'] }
# @!property environment
# The environment that the Consul process starts with.
# @return [Hash]
property :environment, kind_of: Hash, default: lazy { default_environment }
# @!property data_dir
# @return [String]
property :data_dir, kind_of: String, default: lazy { node['consul']['config']['data_dir'] }
# @!property config_dir
# @return [String]
property :config_dir, kind_of: String, default: lazy { node['consul']['service']['config_dir'] }
# @!property nssm_params
# @return [Hash]
property :nssm_params, kind_of: Hash, default: lazy { node['consul']['service']['nssm_params'] }
# @!property systemd_params
# @return [Hash]
property :systemd_params, kind_of: Hash, default: lazy { node['consul']['service']['systemd_params'] }
# @!property program
# The location of the Consul executable.
# @return [String]
property :program, kind_of: String, default: '/usr/local/bin/consul'
# @!property acl_token
# The ACL token. Needed to reload the Consul service on Windows
# @return [String]
property :acl_token, kind_of: String, default: lazy { node['consul']['config']['acl_master_token'] }
# @!property restart_on_update
# Restart on service config change
# @return [Boolean]
property :restart_on_update, kind_of: [TrueClass, FalseClass], default: true

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
        ExecStart: command(new_resource.config_file, new_resource.config_dir),
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
