class Chef::Resource::ConsulService < Chef::Resource::LWRPBase
  self.resource_name = :consul_service
  actions :create, :delete, :start, :stop, :restart
  default_action :create
end
