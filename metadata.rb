name             'consul'
maintainer       'John Bellone'
maintainer_email 'jbellone@bloomberg.net'
license          'Apache v2.0'
description      'Installs/Configures consul'
long_description 'Installs/Configures consul'
version          '0.2.2'

recipe 'consul', 'Installs and starts consul service.'
recipe 'consul::binary_install', 'Installs consul service from binary.'
recipe 'consul::source_install', 'Install consul service from source.'

%w(redhat centos ubuntu debian).each { |os| supports os }

depends 'ark', '~> 0.8.0'
depends 'golang', '~> 1.3.0'

%w(yum-repoforge).each { |cb| depends cb }
