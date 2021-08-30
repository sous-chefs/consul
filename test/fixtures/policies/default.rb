name 'default'
default_source :supermarket
default_source :chef_repo, '..'
cookbook 'consul', path: '../../..'
cookbook 'ark', '= 5.0.0', :supermarket
run_list 'consul_spec::default'
named_run_list :client, 'consul::default'
