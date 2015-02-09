class Chef::Provider::ConsulClientBinary < Chef::Provider::ConsulClient
  action :create do
    include_recipe 'libarchive::default'

    archive = remote_file "#{Chef::Config[:file_cache_path]}/consul-#{new_resource.version}.zip" do
      source new_resource.url
      checksum new_resource.checksum
    end

    libarchive_file ::File.basename(archive.path) do
      path archive.path
      extract_to new_resource.path
      extract_options :no_overwrite
      action :extract
    end

    directory ::Dir.dirname(new_resource.filename) do
      recursive true
      owner 'root'
      group 'root'
      mode '00755'
    end

    link ::File.join(new_resource.path, 'consul') do
      to new_resource.filename
    end
  end
end
