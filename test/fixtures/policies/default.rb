name 'default'
default_source :supermarket
default_source :chef_repo, '..'
cookbook 'consul', path: '../../..'
run_list 'consul_spec::default'
named_run_list :freebsd, 'freebsd::default', 'sudo::default', run_list
named_run_list :client, 'consul::default'
