class Chef::Provider::ConsulClientBinary < Chef::Provider::ConsulClient
  action :create do
    include_recipe 'libarchive::default'

    archive = remote_file Chef::Consul.cached_archive(node) do
      source Chef::Consul.remote_url(node)
      checksum Chef::Consul.remote_checksum(node)
    end

    libarchive_file 'consul.zip' do
      path archive.path
      extract_to Chef::Consul.install_path(node)
      extract_options :no_overwrite

      action :extract
    end

    directory File.basename(Chef::Consul.active_binary(node)) do
      recursive true
      action :create
    end

    link Chef::Consul.active_binary(node) do
      to Chef::Consul.latest_binary(node)
    end
  end
end
