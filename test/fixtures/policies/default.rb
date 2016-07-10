name 'consul'
default_source :community
cookbook 'consul', path: '.'
run_list 'consul::default'
named_run_list :redhat, 'redhat::default', 'consul::default', run_list
named_run_list :ubuntu, 'ubuntu::default', 'consul::default', run_list
override['consul']['config']['bootstrap'] = true
override['consul']['config']['server'] = true
