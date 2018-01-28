# since Consul 0.9.0 enable_script_checks is required to allow scripts to run
# https://www.consul.io/docs/agent/options.html#_enable_script_checks
# this allows the consul_definition recipe to run correctly
node.default['consul']['config']['enable_script_checks'] = true

include_recipe 'apt::default' if node.platform_family?('debian')

include_recipe 'consul::default'
include_recipe 'consul_spec::consul_definition'
include_recipe 'consul_spec::consul_watch'
include_recipe 'consul_spec::consul_acl' unless node.platform_family?('windows')
