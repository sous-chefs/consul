class Chef::Provider::ConsulClient < Chef::Provider::LWRPBase
  use_inline_resources if defined?(use_inline_resources)

  def whyrun_supported?
    true
  end

  action :create do
    user node['consul']['user'] do
      system true
      comment 'consul service user'
      home '/dev/null'
      shell '/bin/false'
      not_if { username == 'root' }
    end

    group node['consul']['group'] do
      system true
      append true
      members node['consul']['user']
      not_if { group_name == 'root' }
    end

    directory node['consul']['data_dir'] do
      user node['consul']['user']
      group node['consul']['group']
      mode 0755
    end

    directory node['consul']['config_dir'] do
      user node['consul']['user']
      group node['consul']['group']
      mode 0755
    end
  end

  action :delete do
    directory node['consul']['data_dir'] do
      action :delete
    end
  end
end
