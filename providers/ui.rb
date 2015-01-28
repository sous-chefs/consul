def whyrun_supported?
	true
end

action :create do
	if @current_resource.exists
		Chef::Log.info "#{ @new_resource } already exists - nothing to do."
	else
		converge_by("Create #{ @new_resource }") do
		create_ui
		end
	end
end

def load_current_resource
	@current_resource = Chef::Resource::ConsulUi.new(@new_resource.name)
	@current_resource.ui_dir(@new_resource.ui_dir)

	if Dir.exists?(@current_resource.ui_dir)
		@current_resource.exists = true
	end
end

def create_ui
	Chef::Log.info("Setting up consul ui")

	run_context.include_recipe 'ark::default'

	install_version = [new_resource.version, 'web_ui'].join('_')
	install_checksum = new_resource.checksums.fetch(install_version)

	ark "consul_ui_#{new_resource.name}" do
		path new_resource.data_dir
		home_dir new_resource.ui_dir
		version new_resource.version
		checksum install_checksum
		url new_resource.base_url % { version: install_version }
	end

end