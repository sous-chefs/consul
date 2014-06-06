require 'json'

# Determine service params
service_config = {}
service_config['data_dir'] = node[:consul][:data_dir]

case node[:consul][:service_mode]
when 'bootstrap'
  service_config['server'] = true
  service_config['bootstrap'] = true
when 'server'
  service_config['server'] = true
  service_config['start_join'] = node[:consul][:servers]
when 'client'
  service_config['start_join'] = node[:consul][:servers]
else
  raise 'node[:consul][:service_mode] must be "bootstrap", "server", or "client"'
end

if node[:consul][:serve_ui]
  service_config[:ui_dir] = node[:consul][:ui_dir]
  service_config[:client_addr] = node[:consul][:client_addr]
end

directory node[:consul][:config_dir]

template '/etc/init.d/consul' do
  source 'consul-init.erb'
  mode 0755
  variables(
    consul_binary: "#{node[:consul][:install_dir]}/consul",
    config_dir: node[:consul][:config_dir],
  )
end

file node[:consul][:config_dir] + "/default.json" do
  user "root"
  group "root"
  mode "0600"
  action :create
  content JSON.pretty_generate(service_config, quirks_mode: true)
end

service 'consul' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
