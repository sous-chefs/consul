class Chef::Provider::ConsulService < Chef::Provider::LWRPBase
  use_inline_resources if defined?(use_inline_resources)

  def whyrun_supported?
    true
  end

  action :create do
    consul_client 'consul' do
      action :create
    end
  end

  action :delete do
    consul_client 'consul' do
      action :delete
    end
  end
end
