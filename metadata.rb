name 'consul'
maintainer 'John Bellone'
maintainer_email 'jbellone@bloomberg.net'
license 'Apache 2.0'
description 'Application cookbook which installs and configures Consul.'
long_description 'Application cookbook which installs and configures Consul.'
version '2.0.0'

recipe 'consul::default', 'Installs and configures the Consul service.'
recipe 'consul::web_ui', 'Installs and configures the Consul Web UI.'
recipe 'consul::client_gem', 'Installs the Consul Ruby client as a gem.'

supports 'centos', '>= 6.4'
supports 'redhat', '>= 6.4'
supports 'ubuntu', '>= 12.04'
supports 'solaris2'
supports 'freebsd'
supports 'arch'
supports 'windows'

depends 'chef-sugar'
depends 'chef-vault', '~> 1.3'
depends 'nssm'
depends 'golang'
depends 'firewall', '~> 2.0'
depends 'libartifact', '~> 1.3'
depends 'poise', '~> 2.2'
depends 'poise-service', '~> 1.0'
depends 'yum-epel'

source_url 'https://github.com/johnbellone/consul-cookbook' if respond_to?(:source_url)
issues_url 'https://github.com/johnbellone/consul-cookbook/issues' if respond_to?(:issues_url)
