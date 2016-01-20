#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2015, Bloomberg Finance L.P.
#

node.default['nssm']['install_location'] = '%WINDIR%'

if node['firewall']['allow_consul']
  include_recipe 'firewall::default'

  # Don't open ports that we've disabled
  ports = node['consul']['config']['ports'].select { |_name, port| port != -1 }

  firewall_rule 'consul' do
    protocol :tcp
    port ports.values
    action :create
    command :allow
  end

  firewall_rule 'consul-udp' do
    protocol :udp
    port ports.values_at('serf_lan', 'serf_wan', 'dns')
    action :create
    command :allow
  end
end

# NSSM will run Consul as the SYSTEM account
if node['os'].eql? 'linux'
  poise_service_user node['consul']['service_user'] do
    group node['consul']['service_group']
  end
end

config = consul_config node['consul']['service_name'] do |r|
  if node['os'].eql? 'linux'
    owner node['consul']['service_user']
    group node['consul']['service_group']
  end

  node['consul']['config'].each_pair { |k, v| r.send(k, v) }
end

consul_service node['consul']['service_name'] do |r|
  if node['os'].eql? 'linux'
    user node['consul']['service_user']
    group node['consul']['service_group']
  end
  version node['consul']['version']
  config_file config.path

  node['consul']['service'].each_pair { |k, v| r.send(k, v) }
  subscribes :restart, "consul_config[#{config.name}]", :delayed
end
