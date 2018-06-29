name 'default'
default_source :supermarket
default_source :chef_repo, '..'
cookbook 'consul', path: '../../..'
cookbook 'apt'
run_list 'apt', 'consul_spec::default'
named_run_list :client, 'consul::default'
