poise_service_user node['consul']['service_user'] do
  group node['consul']['service_group']
end

consul_install node['consul']['service_name'] do |r|
  user node['consul']['service_user']
  group node['consul']['service_group']
  version node['consul']['version']

  node['consul']['install'].each_pair { |k, v| r.send(k, v) }
end
