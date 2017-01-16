name 'default'
default_source :supermarket
default_source :chef_repo, '..'
cookbook 'consul', path: '../../..'
run_list "consul_spec::#{name}"
named_run_list :centos, 'sudo::default', run_list
named_run_list :debian, 'apt::default', run_list
named_run_list :freebsd, 'freebsd::default', 'sudo::default', run_list
named_run_list :windows, 'windows::default', run_list

default['authorization']['sudo']['users'] = %w(kitchen vagrant)
default['authorization']['sudo']['passwordless'] = true
