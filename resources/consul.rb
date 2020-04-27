resource_name :consul

property :version, String, name_property: true
property :install_type, String, required: true, default: 'binary'

default_action :install

action :install do
  version = new_resource.version
  release_url = "https://releases.hashicorp.com/consul/#{version}/#{binary_basename(version)}"
  if new_resource.install_type == 'binary'
    group 'consul'

    user 'consul' do
      group 'consul'
    end

    directory join_path(extract_path, new_resource.version) do
      owner 'consul'
      group 'consul'
      mode '0755'
      recursive true
    end

    archive_path = "#{Chef::Config[:file_cache_path]}/#{binary_basename(version)}"
    remote_file archive_path do
      source release_url
      checksum binary_checksum(version)
    end

    archive_file archive_path do
      destination join_path(extract_path, new_resource.version)
      overwrite true
      not_if { ::File.exist?(consul_program(extract_path)) }
    end

    link '/usr/local/bin/consul' do
      to join_path(extract_path, new_resource.version, 'consul')
      not_if { windows? }
    end

    if windows?
      link "#{node.config_prefix_path}\\consul.exe" do
        to join_path(extract_path, new_resource.version, 'consul.exe')
      end

      windows_path node.config_prefix_path do
        action :add
      end
    end
  end
end

action :remove do
  directory join_path(extract_path, new_resource.version) do
    action :delete
    recursive true
  end

  link '/usr/local/bin/consul' do
    action :delete
  end
end

action_class do
  include Consul::Cookbook::Helpers
end
