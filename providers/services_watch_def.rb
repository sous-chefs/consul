use_inline_resources

action :create do
  file new_resource.path do
    user node['consul']['service_user']
    group node['consul']['service_group']
    mode 0600
    content new_resource.to_json

    action :create
  end
end

action :delete do
  file new_resource.path do
    action :delete
  end
end
