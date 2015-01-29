actions :create
default_action :create

attribute :base_url, :kind_of => String, :default => run_context.node['consul']['base_url'] 
attribute :version, :kind_of => String, :default => run_context.node['consul']['version']
attribute :install_method, :kind_of => String, :default => run_context.node['consul']['install_method']
attribute :install_dir, :kind_of => String, :default => run_context.node['consul']['install_dir']
attribute :checksums, :kind_of => String, :default => run_context.node['consul']['checksums']
attribute :source_revision, :kind_of => String, :default => run_context.node['consul']['source_revision']

attribute :service_mode, :kind_of => String, :default => run_context.node['consul']['service_mode']
attribute :retry_on_join, :kind_of => [TrueClass, FalseClass], :default => run_context.node['consul']['retry_on_join']
attribute :bootstrap_expect, :kind_of => Integer, :default => run_context.node['consul']['bootstrap_expect']

attribute :data_dir, :kind_of => String, :default => run_context.node['consul']['data_dir']
attribute :config_dir, :kind_of => String, :default => run_context.node['consul']['config_dir']
attribute :etc_config_dir, :kind_of => String, :default => run_context.node['consul']['etc_config_dir']
attribute :servers, :kind_of => Array, :default => run_context.node['consul']['servers']

attribute :init_style, :kind_of => String, :default => run_context.node['consul']['init_style']
attribute :service_user, :kind_of => String, :default => run_context.node['consul']['service_user']
attribute :service_group, :kind_of => String, :default => run_context.node['consul']['service_group']

attribute :encrypt_enabled, :kind_of => [TrueClass, FalseClass], :default => run_context.node['consul']['encrypt_enabled']
attribute :encrypt, :kind_of => String, :default => run_context.node['consul']['encrypt']
attribute :verify_incoming, :kind_of => [TrueClass, FalseClass], :default => run_context.node['consul']['verify_incoming']
attribute :verify_outgoing, :kind_of => [TrueClass, FalseClass], :default => run_context.node['consul']['verify_outgoing'] 
attribute :ca_cert, :kind_of => String, :default => run_context.node['consul']['ca_cert']
attribute :ca_path, :kind_of => String, :default => run_context.node['consul']['ca_path']
attribute :cert_file, :kind_of => String, :default => run_context.node['consul']['cert_file']
attribute :cert_path, :kind_of => String, :default => run_context.node['consul']['cert_path']
attribute :key_file, :kind_of => String, :default => run_context.node['consul']['key_file']
attribute :key_file_path, :kind_of => String, :default => run_context.node['consul']['key_file_path']

attribute :bind_interface, :kind_of => String, :default => run_context.node['consul']['bind_interface']
attribute :advertise_interface, :kind_of => String, :default => run_context.node['consul']['advertise_interface']
attribute :advertise_addr, :kind_of => String, :default => run_context.node['consul']['advertise_addr']
attribute :client_interface, :kind_of => String, :default => run_context.node['consul']['client_interface']
attribute :client_addr, :kind_of => String, :default => run_context.node['consul']['client_addr']
attribute :ports, :kind_of => Hash, :default => run_context.node['consul']['ports']

attribute :ui_dir, :kind_of => String, :default => run_context.node['consul']['ui_dir']
attribute :serve_ui, :kind_of => [TrueClass, FalseClass], :default => run_context.node['consul']['serve_ui'] 

attribute :extra_params, :default => run_context.node['consul']['extra_params']

attribute :gopath, :kind_of => String, :default => run_context.node['consul']['gopath']
attribute :gobin, :kind_of => String, :default => run_context.node['consul']['gobin']

attribute :datacenter, :kind_of => String, :default => run_context.node['consul']['datacenter']
attribute :domain, :kind_of => String, :default => run_context.node['consul']['domain']
attribute :log_level, :kind_of => String, :default => run_context.node['consul']['log_level']
attribute :node_name, :kind_of => String, :default => run_context.node['consul']['node_name']
attribute :enable_syslog, :kind_of => [TrueClass, FalseClass], :default => run_context.node['consul']['enable_syslog']

attr_accessor :exists