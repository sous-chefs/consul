class Chef::Provider::ConsulService < Chef::Provider::LWRPBase
  use_inline_resources if defined?(use_inline_resources)

  def whyrun_supported?
    true
  end

  action :delete do

  end

  action :enable do

  end

  action :start do

  end

  action :stop do

  end

  action :restart do

  end
end
