unified_mode true

default_action :create

property :path, String, default: lazy { ::File.join(node['consul']['config_dir'], "#{name}.json") }
property :user, String, default: lazy { node['consul']['service_user'] }
property :group, String, default: lazy { node['consul']['service_group'] }
property :mode, String, default: '0640'
property :type, String, equal_to: %w(check service checks services)
property :parameters, Hash, default: {}

def params_to_json
  final_parameters = parameters
  final_parameters = final_parameters.merge(name: name) if final_parameters[:name].nil?
  JSON.pretty_generate(type => final_parameters)
end

action :create do
  directory ::File.dirname(new_resource.path) do
    recursive true
    unless platform?('windows')
      owner new_resource.user
      group new_resource.group
      mode '0755'
      # Prevent clobbering permissions on the directory since the intent
      # in this context is to set the permissions of the definition file
      not_if { Dir.exist? new_resource.path }
    end
  end

  file new_resource.path do
    content new_resource.params_to_json
    unless platform?('windows')
      owner new_resource.user
      group new_resource.group
      mode new_resource.mode
    end
  end
end

action :delete do
  file new_resource.path do
    action :delete
  end
end
