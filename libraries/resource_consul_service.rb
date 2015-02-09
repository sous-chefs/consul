class Chef::Resource::ConsulService < Chef::Resource::LWRPBase
  self.resource_name = :consul_service
  actions :start, :stop, :restart, :enable, :disable, :reload
  default_action :start

  attribute :service_name, type: String, name_attribute: true, required: true
end
