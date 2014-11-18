name 'consul'
maintainer 'John Bellone'
maintainer_email 'jbellone@bloomberg.net'
license 'Apache v2.0'
description 'Installs/Configures consul'
long_description 'Installs/Configures consul'
version '0.5.2'

recipe 'consul', 'Installs and starts consul service.'
recipe 'consul::install_binary', 'Installs consul service from binary.'
recipe 'consul::install_source', 'Installs consul service from source.'
recipe 'consul::ui', 'Installs consul ui service.'

%w(redhat centos).each do |name|
  supports name, '~> 7.0'
  supports name, '~> 6.5'
  supports name, '~> 5.10'
end

supports 'ubuntu', '= 12.04'
supports 'ubuntu', '= 14.04'

depends 'ark'
depends 'golang', '~> 1.3.0'
depends 'runit'
depends 'yum-repoforge'
