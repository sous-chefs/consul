name              'consul'
maintainer        'Sous Chefs'
maintainer_email  'help@sous-chefs.org'
license           'Apache-2.0'
description       'Application cookbook which installs and configures Consul.'
source_url        'https://github.com/sous-chefs/consul'
issues_url        'https://github.com/sous-chefs/consul/issues'
chef_version      '>= 13.4'
version           '4.3.1'
supports 'centos', '>= 7.0'
supports 'redhat', '>= 7.0'
supports 'debian', '>= 9.0'
supports 'ubuntu', '>= 16.04'
name 'consul'
maintainer 'John Bellone'
maintainer_email 'jbellone@bloomberg.net'
license 'Apache-2.0'
description 'Application cookbook which installs and configures Consul.'
long_description 'Application cookbook which installs and configures Consul.'
version '9003.1.13'

recipe 'consul::default', 'Installs and configures the Consul service.'
recipe 'consul::client_gem', 'Installs the Consul Ruby client as a gem.'

supports 'centos', '>= 6.4'
supports 'redhat', '>= 6.4'
supports 'ubuntu', '>= 12.04'
supports 'solaris2'
supports 'arch'
supports 'windows'

depends 'build-essential', '>= 5.0.0' # cookstyle: disable ChefModernize/UnnecessaryDependsChef14
depends 'nssm', '>= 4.0.0'
depends 'golang'
depends 'poise', '~> 2.2'
depends 'poise-archive', '~> 1.3'
depends 'poise-service', '~> 1.4'
depends 'windows', '>= 3.1'

source_url 'https://github.com/johnbellone/consul-cookbook' if respond_to?(:source_url)
issues_url 'https://github.com/johnbellone/consul-cookbook/issues' if respond_to?(:issues_url)

chef_version '>= 12.1' if respond_to?(:chef_version)
