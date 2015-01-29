require 'json'

def whyrun_supported?
  true
end

action :create do
  if @current_resource.exists
    Chef::Log.info "#{ @new_resource } already exists - nothing to do."
  else
    converge_by("Create #{ @new_resource }") do
    create_consul
    end
  end
end

def load_current_resource
  @current_resource = Chef::Resource::ConsulAgent.new(@new_resource.name)
  @current_resource.data_dir(@new_resource.data_dir)
  @current_resource.config_dir(@new_resource.config_dir)

  if Dir.exists?(@current_resource.data_dir) or Dir.exists?(@current_resource.config_dir)
    @current_resource.exists = true
  end
end

def create_consul
  Chef::Log.info("Setting up new consul service: #{new_resource.name}")

  if new_resource.install_method == 'binary'

    run_context.include_recipe 'ark::default'
    install_arch = node['kernel']['machine'] =~ /x86_64/ ? 'amd64' : '386'
    install_version = [new_resource.version, node['os'], install_arch].join('_')
    install_checksum = new_resource.checksums.fetch(install_version)

  ark 'consul' do
    path new_resource.install_dir
    version new_resource.version
    checksum install_checksum
    url new_resource.base_url % { version: install_version }
    action :dump
  end

  file ::File.join(new_resource.install_dir, 'consul') do
    mode '0755'
    action :touch
  end 

  else
    run_context.include_recipe 'apt::default'
    run_context.include_recipe 'golang::default'

    directory ::File.join(node['go']['gopath'], 'src/github.com/hashicorp') do
      owner 'root'
      group 'root'
      mode '00755'
      recursive true
      action :create
    end

    git ::File.join(node['go']['gopath'], '/src/github.com/hashicorp/consul') do
      repository 'https://github.com/hashicorp/consul.git'
      reference new_resource.source_revision
      action :checkout
    end

    golang_package 'github.com/hashicorp/consul' do
      action :install
    end

    link ::File.join(new_resource.install_dir, 'consul') do
      to ::File.join(node['go']['gobin'], 'consul')
    end
  end

  # Configure directories
  consul_directories = []
  consul_directories << new_resource.data_dir
  consul_directories << new_resource.config_dir
  consul_directories << '/var/lib/consul'

  if new_resource.init_style == 'runit'
    run_context.include_recipe 'runit::default'
    consul_directories << "/var/log/consul_#{new_resource.name}"
  end

  consul_user = new_resource.service_user
  consul_group = new_resource.service_group

  # Create service user
  user "consul service user: #{consul_user}" do
    not_if { consul_user == 'root' }
    username consul_user
    home '/dev/null'
    shell '/bin/false'
    comment 'consul service user'
  end

  # Create service group
  group "consul service group: #{consul_group}" do
    not_if { consul_group == 'root' }
    group_name consul_group
    members consul_user
    append true
  end

  # Create service directories
  consul_directories.each do |dirname|
    directory dirname do
      owner consul_user
      group consul_group
      mode 0755
    end
  end

  # Determine service params
  service_config = JSON.parse(new_resource.extra_params.to_json)
  service_config['data_dir'] = new_resource.data_dir
  num_cluster = new_resource.bootstrap_expect
  join_mode = new_resource.retry_on_join ? 'retry_join' : 'start_join'

  case new_resource.service_mode
  when 'bootstrap'
    service_config['server'] = true
    service_config['bootstrap'] = true
  when 'cluster'
    service_config['server'] = true
    if num_cluster > 1
      service_config['bootstrap_expect'] = num_cluster
      service_config['join_mode'] = new_resource.servers
    else
      service_config['bootstrap'] = true
    end
  when 'server'
    service_config['server'] = true
    service_config['join_mode'] = new_resource.servers
  when 'client'
    service_config['join_mode'] = new_resource.servers
  else
    Chef::Application.fatal! %Q("#{new_resource.service_mode}" must be "bootstrap", "cluster", "server", or "client")
  end

  iface_addr_map = {
    bind_interface: :bind_addr,
    advertise_interface: :advertise_addr,
    client_interface: :client_addr
  }

  iface_addr_map.each_pair do |interface,addr|
    next unless node['consul'][interface]

    selected_interface = new_resource.send(interface.to_sym)
    
    if node["network"]["interfaces"][run_context.node['consul'][interface]]
      ip = node["network"]["interfaces"][selected_interface]["addresses"].detect{|k,v| v[:family] == "inet"}.first
      service_config[addr] = ip 
    else
      Chef::Application.fatal!("Interface specified in node['consul'][#{interface}] does not exist!")
    end
  end

  if new_resource.serve_ui
    service_config['ui_dir'] = new_resource.ui_dir
    service_config['client_addr'] = new_resource.client_addr
  end

  copy_params = [
    :datacenter, :domain, :log_level, :node_name, :ports, :enable_syslog
  ]

  copy_params.each do |key|

    new_resource.send(key.to_sym)

    if new_resource.to_hash[key]
      if key == :ports
        Chef::Application.fatal! 'ports must be a Hash' unless new_resource.to_hash[key].kind_of?(Hash)
      end
      service_config[key] = new_resource.to_hash[key]
    end
  end

  dbi = nil
  # Gossip encryption
  if new_resource.encrypt_enabled 
    # Fetch the databag only once, and use empty hash if it doesn't exists
    dbi = consul_encrypted_dbi || {}
    secret = consul_dbi_key_with_node_default(dbi, 'encrypt')
    raise "Consul encrypt key is empty or nil" if secret.nil? or secret.empty?
    service_config['encrypt'] = secret
  else
    # for backward compatibilty
    service_config['encrypt'] = node.consul.encrypt unless node.consul.encrypt.nil?
  end

  # TLS encryption
  if new_resource.verify_incoming || new_resource.verify_outgoing
    dbi = consul_encrypted_dbi || {} if dbi.nil?
    service_config['verify_outgoing'] = new_resource.verify_outgoing
    service_config['verify_incoming'] = new_resource.verify_incoming

    ca_path = new_resource.ca_path % { config_dir: new_resource.config_dir }
    service_config['ca_file'] = ca_path

    cert_path = new_resource.cert_path % { config_dir: new_resource.config_dir }
    service_config['cert_file'] = cert_path

    key_path = new_resource.key_file_path % { config_dir: new_resource.config_dir }
    service_config['key_file'] = key_path

    # Search for key_file_hostname since key and cert file can be unique/host
    key_content = dbi['key_file_' + node.fqdn] || consul_dbi_key_with_node_default(dbi, 'key_file')
    cert_content = dbi['cert_file_' + node.fqdn] || consul_dbi_key_with_node_default(dbi, 'cert_file')
    ca_content = consul_dbi_key_with_node_default(dbi, 'ca_cert')

    # Save the certs if exists
    {ca_path => ca_content, key_path => key_content, cert_path => cert_content}.each do |path, content|
      unless content.nil? or content.empty?
        file path do
          user consul_user
          group consul_group
          mode 0600
          action :create
          content content
        end
      end
    end
  end

  consul_config_filename = ::File.join(new_resource.config_dir, 'default.json')

  file consul_config_filename do
    user consul_user
    group consul_group

    mode 0600
    action :create
    content JSON.pretty_generate(service_config, quirks_mode: true)
    # https://github.com/johnbellone/consul-cookbook/issues/72
    notifies :restart, "service[consul_#{new_resource.name}]"
  end

  case new_resource.init_style
  when 'init'
    if platform?("ubuntu")
      init_file = "/etc/init/consul_#{new_resource.name}.conf"
      init_tmpl = 'consul.conf.erb'
    else
      init_file = "/etc/init.d/consul_#{new_resource.name}"
      init_tmpl = 'consul-init.erb'
    end

    template new_resource.etc_config_dir do
      source 'consul-sysconfig.erb'
      mode 0755
      notifies :create, "template[#{init_file}]", :immediately
    end

    template init_file do
      source init_tmpl
      mode 0755
      variables(
        consul_binary: "#{new_resource.install_dir}/consul",
        config_dir: new_resource.config_dir,
        consul_instance: new_resource.name
      )
      notifies :restart, "service[consul_#{new_resource.name}]", :immediately
    end

    service "consul_#{new_resource.name}" do
      provider Chef::Provider::Service::Upstart if platform?("ubuntu")
      supports status: true, restart: true, reload: true
      action [:enable, :start]
      subscribes :restart, "file[#{consul_config_filename}", :delayed
    end
        
    when 'runit'
      runit_service "consul_#{new_resource.name}" do
      supports status: true, restart: true, reload: true
      action [:enable, :start]
      subscribes :restart, "file[#{consul_config_filename}]", :delayed
      log true
      options(
        consul_binary: "#{new_resource.install_dir}/consul",
        config_dir: new_resource.config_dir,
        consul_instance: new_resource.name
      )
      run_template_name 'consul'
      log_template_name 'consul'
      end

    service "consul_#{new_resource.name}" do
      supports status: true, restart: true, reload: true
      reload_command "'#{node['runit']['sv_bin']}' hup consul_#{new_resource.name}"
    end
  end
end