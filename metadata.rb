name             'consul'
maintainer       'John Bellone'
maintainer_email 'jbellone@bloomberg.net'
license          'Apache 2.0'
description      'Installs/Configures consul'
long_description 'Installs/Configures consul'
version          '0.1.0'

%w(ubuntu redhat).each do |flavor|
  supports flavor
end

suggests 'ark'
suggests 'golang'
