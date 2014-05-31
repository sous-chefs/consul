# Determine servers to connect to
server_conn = node[:consul][:servers].map{|s| "-join=#{s}"}.join(' ')

# Determine service params
case node[:consul][:service_mode]
when 'bootstrap'
  service_params = '-server -bootstrap'
when 'server'
  service_params = "-server #{server_conn}"
when 'client'
  service_params = server_conn
else
  raise 'node[:consul][:service_mode] must be "bootstrap", "server", or "client"'
end

if node[:consul][:serve_ui]
  service_params = "#{service_params} -ui-dir #{node[:consul][:ui_dir]}/consul_ui -client #{node[:consul][:client_addr]}"
end

directory node[:consul][:config_dir]

template '/etc/init.d/consul' do
  source 'consul-init.erb'
  mode 0755
  variables(
    consul_binary: "#{node[:consul][:install_dir]}/consul",
    data_dir: node[:consul][:data_dir],
    config_dir: node[:consul][:config_dir],
    service_params: service_params
  )
end

service 'consul' do
  supports status: true, restart: true
  action [:enable, :start]
end
