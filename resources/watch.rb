property :watch_file, String, name_property: true
property :owner, String, default: 'root'
property :group, String, default: 'consul'
property :config_dir, String, default: '/etc/consul/conf.d'

default_action :create

action :create do

end