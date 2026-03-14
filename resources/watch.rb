# frozen_string_literal: true

provides :consul_watch
unified_mode true

default_action :create

property :path, String, default: lazy { ::File.join('/etc/consul/conf.d', "#{name}.json") }
property :user, String, default: 'consul'
property :group, String, default: 'consul'
property :type, String, equal_to: %w(checks event key keyprefix nodes service services)
property :parameters, Hash, default: {}

def params_to_json
  JSON.pretty_generate(watches: [{ type: type }.merge(parameters)])
end

action :create do
  directory ::File.dirname(new_resource.path) do
    recursive true
    owner new_resource.user
    group new_resource.group
    mode '0755'
  end

  file new_resource.path do
    content new_resource.params_to_json
    owner new_resource.user
    group new_resource.group
    mode '0640'
  end
end

action :delete do
  file new_resource.path do
    action :delete
  end
end
