name 'consul'
default_source :community
cookbook 'consul', path: '.'
run_list 'consul::default'
named_run_list :centos, 'yum::default', 'consul::default', run_list
named_run_list :debian, 'apt::default', 'consul::default', run_list
override['consul']['config']['bootstrap'] = true
override['consul']['config']['server'] = true
