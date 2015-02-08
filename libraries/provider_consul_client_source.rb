class Chef::Provider::ConsulServiceSource < Chef::Provider::ConsulService
  action :create do
    super
    include_recipe 'golang::default'

    directory File.join(node['go']['gopath'], 'src/github.com/hashicorp') do
      owner 'root'
      group 'root'
      mode '00755'
      recursive true
      action :create
    end

    git File.join(node['go']['gopath'], '/src/github.com/hashicorp/consul') do
      repository 'https://github.com/hashicorp/consul.git'
      reference node['consul']['source_revision']
      action :checkout
    end

    golang_package 'github.com/hashicorp/consul' do
      action :install
    end

    directory File.basename(Chef::Consul.active_binary(node)) do
      recursive true
      action :create
    end

    link Chef::Consul.active_binary(node) do
      to Chef::Consul.source_binary(node)
    end
  end
end
