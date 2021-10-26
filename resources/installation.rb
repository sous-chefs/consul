unified_mode true

default_action :create

property :version, String, name_property: true

def consul_program
  bin = node.join_path(node.platform_family?('windows') ? node.config_prefix_path : '/opt/consul', version, 'consul')
  node.windows? ? "#{bin}.exe" : bin
end

action_class do
  include ConsulCookbook::ResourceHelpers
end

action :create do
  attrs = node['consul']['install']['binary']

  directory ::File.dirname(consul_program) do
    unless node.windows?
      mode '0755'
    end
    recursive true
  end

  # TODO: replace remote_file + extract with archive_file when Chef>15
  basename = attrs['archive_basename'] || binary_basename(new_resource)
  archive_path = node.join_path(Chef::Config[:file_cache_path], basename)
  remote_file archive_path do
    source format(attrs['archive_url'], version: new_resource.version, basename: basename)
    checksum binary_checksum(node, new_resource.version)
  end

  if archive_path.end_with?('.zip')
    chef_gem 'rubyzip'
    require 'zip'

    file consul_program do
      content lazy { Zip::File.open(archive_path).find_entry(::File.basename(consul_program)).get_input_stream.read }
      unless platform?('windows')
        owner node['consul']['service_user']
        group node['consul']['service_group']
        mode '0755'
      end
    end
  else # linux/tgz
    execute 'extract consul binary' do
      command "tar -zxf #{archive_path} -C #{::File.dirname(consul_program)} && chmod 0755 #{consul_program}"
      creates consul_program
    end
  end

  link '/usr/local/bin/consul' do
    to consul_program
    not_if { node.windows? }
  end

  windows_path node.config_prefix_path do
    action :add
    only_if { node.windows? }
  end
end

action :remove do
  directory ::File.dirname(consul_program) do
    action :delete
    recursive true
  end
end
