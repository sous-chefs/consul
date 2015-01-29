name 'consul'
maintainer 'John Bellone'
maintainer_email 'jbellone@bloomberg.net'
license 'Apache v2.0'
description 'Installs/Configures Consul client, server and UI.'
long_description 'Installs/Configures Consul client, server and UI.'
version '0.7.1'

recipe 'consul', 'Installs and starts consul service.'
recipe 'consul::ui', 'Installs consul ui service.'

%w(redhat centos).each do |name|
  supports name, '~> 7.0'
  supports name, '~> 6.5'
  supports name, '~> 5.10'
end

supports 'ubuntu', '= 10.04'
supports 'ubuntu', '= 12.04'
supports 'ubuntu', '= 14.04'

depends 'apt'
depends 'ark'
depends 'chef-provisioning'
depends 'golang', '~> 1.4'
depends 'runit'
depends 'yum-repoforge'
