actions :create
default_action :create

attribute :base_url, :kind_of => String, :default => run_context.node['consul']['base_url'] 
attribute :version, :kind_of => String, :default => run_context.node['consul']['version']
attribute :checksums, :kind_of => String, :default => run_context.node['consul']['checksums']
attribute :data_dir, :kind_of => String, :default => run_context.node['consul']['data_dir']
attribute :config_dir, :kind_of => String, :default => run_context.node['consul']['config_dir']
attribute :ui_dir, :kind_of => String, :default => run_context.node['consul']['ui_dir']

attr_accessor :exists