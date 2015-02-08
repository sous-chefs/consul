class Chef::Resource::ConsulClient < Chef::Resource::LWRPBase
  self.resource_name = :consul_client
  actions :create, :delete
  default_action :create
end
