default_source :community
default_source :chef_repo, '..'
cookbook 'consul', path: '../../..'
run_list 'consul::default', "consul_spec::#{name}"
named_run_list :centos, 'yum::default', 'yum-centos::default',run_list
named_run_list :debian, 'apt::default', run_list
named_run_list :freebsd, 'freebsd::default', 'sudo::default',  run_list
named_run_list :windows, 'windows::default', run_list
