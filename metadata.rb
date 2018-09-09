name 'consul'
maintainer 'Sous Chefs'
maintainer_email 'help@sous-chefs.org'
license 'Apache-2.0'
description 'Application cookbook which installs and configures Consul.'
long_description 'Application cookbook which installs and configures Consul.'
version '3.1.0'

recipe 'consul::default', 'Installs and configures the Consul service.'
recipe 'consul::client_gem', 'Installs the Consul Ruby client as a gem.'

supports 'centos', '>= 6.4'
supports 'redhat', '>= 6.4'
supports 'ubuntu', '>= 12.04'
supports 'solaris2'
supports 'arch'
supports 'windows'

# build-essential is obsolete in chef 14+
depends 'build-essential' # ~FC121
depends 'nssm', '>= 4.0.0'
depends 'golang'
depends 'poise', '~> 2.2'
depends 'poise-archive', '~> 1.3'
depends 'poise-service', '~> 1.4'
depends 'windows', '~> 3.1'

source_url 'https://github.com/sous-chefs/consul'
issues_url 'https://github.com/sous-chefs/consul/issues'

chef_version '>= 12.1'
