name 'consul'
default_source :community
cookbook 'consul', path: '.'
run_list 'consul::default'
