name 'consul'
maintainer 'John Bellone'
maintainer_email 'jbellone@bloomberg.net'
license 'Apache 2.0'
description 'Application cookbook which installs and configures Consul.'
long_description 'Application cookbook which installs and configures Consul.'
version '1.3.1'

recipe 'consul::default', 'Installs, configures and starts the Consul service.'

supports 'centos', '>= 6.4'
supports 'redhat', '>= 6.4'
supports 'ubuntu', '>= 12.04'
supports 'arch'
supports 'windows'

depends 'chef-vault', '~> 1.3'
depends 'nssm'
depends 'golang'
depends 'firewall', '~> 2.0'
depends 'libartifact', '~> 1.3'
depends 'poise', '~> 2.2'
depends 'poise-service', '~> 1.0'

source_url 'https://github.com/johnbellone/consul-cookbook' if respond_to?(:source_url)
issues_url 'https://github.com/johnbellone/consul-cookbook/issues' if respond_to?(:issues_url)
