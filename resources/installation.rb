unified_mode true

default_action :create

property :version, String, name_property: true

include ConsulCookbook::Helpers

def consul_program
  bin = join_path(platform?('windows') ? config_prefix_path : '/opt/consul', version, 'consul')
  platform?('windows') ? "#{bin}.exe" : bin
end

action_class do
  include ConsulCookbook::ResourceHelpers
end

action :create do
  attrs = node['consul']['install']['binary']
  basename = attrs['archive_basename'] || binary_basename(new_resource)
  archive_path = ::File.join(Chef::Config[:file_cache_path], basename)
  remote_file archive_path do
    source format(attrs['archive_url'], version: new_resource.version, basename: basename)
    checksum binary_checksum(node, new_resource.version)
  end

  archive_file archive_path do
    destination ::File.dirname(consul_program)
  end

  link '/usr/local/bin/consul' do
    to consul_program
    not_if { platform?('windows') }
  end

  windows_path ::File.dirname(consul_program) do
    action :add
    only_if { platform?('windows') }
  end
end

action :remove do
  directory ::File.dirname(consul_program) do
    action :delete
    recursive true
  end
end
