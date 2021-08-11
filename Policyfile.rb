name 'consul'
default_source :supermarket
cookbook 'consul', path: '.'
run_list 'consul::default'
