name 'consul'
run_list 'consul::default'
default_source :community
cookbook 'consul', path: '.'
