#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright:: 2014-2016, Bloomberg Finance L.P.
#

default['consul']['service_name'] = 'consul'
default['consul']['service_user'] = 'consul'
default['consul']['service_group'] = 'consul'
default['consul']['create_service_user'] = true

#Consul Config section - Alphabetical order
default['consul']['config']['ca_file'] = join_path config_prefix_path, 'ssl', 'CA', 'ca.crt'
default['consul']['config']['cert_file'] = join_path config_prefix_path, 'ssl', 'certs', 'consul.crt'
default['consul']['config']['client_addr'] = '0.0.0.0'
default['consul']['config']['data_dir'] = data_path

# The mere presence of the below line breaks config derived prior to its introduction.
# This breaks the kitchen tests.
# The value can still be used, it just will omit itself by default.
# When https://github.com/sous-chefs/consul/issues/520 is fixed,
# we can use the later versions that support this as we fail for other reasons later.
# default['consul']['config']['enable_local_script_checks'] = true

default['consul']['config']['key_file'] = join_path config_prefix_path, 'ssl', 'private', 'consul.key'
default['consul']['config']['path'] = join_path config_prefix_path, 'consul.json'
default['consul']['config']['ports'] = {
  'dns' => 8600,
  'http' => 8500,
  'serf_lan' => 8301,
  'serf_wan' => 8302,
  'server' => 8300,
}

default['consul']['diplomat_version'] = nil

default['consul']['service']['config_dir'] = join_path config_prefix_path, 'conf.d'

default['consul']['version'] = '1.2.4'

# Our repo for testing enterprise packages.
# Use this location when testing enterprise.
# default['consul']['archive_url_root'] = 'https://cdn.aws.robloxlabs.com'
default['consul']['archive_url_root'] = 'https://releases.hashicorp.com'

# When turning this to true, be sure the enterprise packages are located
# at archive_url_root.
default['consul']['enterprise'] = false

# Windows only
default['consul']['service']['nssm_params'] = {
  'AppDirectory' => data_path,
  'AppStdout' => join_path(config_prefix_path, 'stdout.log'),
  'AppStderr' => join_path(config_prefix_path, 'error.log'),
  'AppRotateFiles' => 1,
  'AppRotateOnline' => 1,
  'AppRotateBytes' => 20_000_000,
}
