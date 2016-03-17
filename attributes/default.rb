#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#

default['consul']['service_name'] = 'consul'
default['consul']['service_user'] = 'consul'
default['consul']['service_group'] = 'consul'

default['consul']['config']['path'] = join_path config_prefix_path, 'consul.json'
default['consul']['config']['data_dir'] = data_path
default['consul']['config']['ca_file'] = join_path config_prefix_path, 'ssl', 'CA', 'ca.crt'
default['consul']['config']['cert_file'] = join_path config_prefix_path, 'ssl', 'certs', 'consul.crt'
default['consul']['config']['key_file'] = join_path config_prefix_path, 'ssl', 'private', 'consul.key'

default['consul']['config']['client_addr'] = '0.0.0.0'
default['consul']['config']['ports'] = {
  'dns'      => 8600,
  'http'     => 8500,
  'rpc'      => 8400,
  'serf_lan' => 8301,
  'serf_wan' => 8302,
  'server'   => 8300
}

default['consul']['diplomat_version'] = nil

default['consul']['service']['config_dir'] = join_path config_prefix_path, 'conf.d'

default['consul']['version'] = '0.6.4'

# Windows only
default['consul']['service']['nssm_params'] = {
  'AppDirectory'     => data_path,
  'AppStdout'        => join_path(config_prefix_path, 'stdout.log'),
  'AppStderr'        => join_path(config_prefix_path, 'error.log'),
  'AppRotateFiles'   => 1,
  'AppRotateOnline'  => 1,
  'AppRotateBytes'   => 20_000_000
}
