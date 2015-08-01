#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#
default['consul']['service_name'] = 'consul'
default['consul']['service_user'] = 'consul'
default['consul']['service_group'] = 'consul'

default['consul']['bag_name'] = 'secrets'
default['consul']['bag_item'] = 'consul'

default['consul']['config']['path'] = '/etc/consul.json'
default['consul']['config']['data_dir'] = '/var/lib/consul'
default['consul']['config']['ca_file'] = '/etc/consul/ssl/CA/ca.crt'
default['consul']['config']['cert_file'] = '/etc/consul/ssl/certs/consul.crt'
default['consul']['config']['client_addr']  = '0.0.0.0'
default['consul']['config']['key_file'] = '/etc/consul/ssl/private/consul.key'
default['consul']['config']['ports'] = {
  'dns'      => 8600,
  'http'     => 8500,
  'rpc'      => 8400,
  'serf_lan' => 8301,
  'serf_wan' => 8302,
  'server'   => 8300
}

default['consul']['service']['install_method'] = 'binary'
default['consul']['service']['config_dir'] = '/etc/consul'
default['consul']['service']['binary_url'] = "https://dl.bintray.com/mitchellh/consul/%{filename}.zip" # rubocop:disable Style/StringLiterals
default['consul']['service']['source_url'] = 'https://github.com/hashicorp/consul'

default['consul']['version'] = '0.5.2'
default['consul']['checksums'] = {
  '0.5.0_darwin_amd64' => '24d9758c873e9124e0ce266f118078f87ba8d8363ab16c2e59a3cd197b77e964',
  '0.5.0_linux_386'    => '4b6147c30596a30361d4753d409f8a1af9518f54f5ed473a4c4ac973738ac0fd',
  '0.5.0_linux_amd64'  => '161f2a8803e31550bd92a00e95a3a517aa949714c19d3124c46e56cfdc97b088',
  '0.5.0_windows_386'  => '7fd760ee8a5c2756391cacc1e924ae602b16cdad838db068e564f798383ad714',
  '0.5.0_web_ui'       => '0081d08be9c0b1172939e92af5a7cf9ba4f90e54fae24a353299503b24bb8be9',

  '0.5.1_darwin_amd64' => '06fef2ffc5a8ad8883213227efae5d1e0aa4192ccb772ec6086103a7a08fadf8',
  '0.5.1_linux_386'    => 'dad93a02c01de885daee191bcc5a05ca2bf106200da61db33694a658432d8399',
  '0.5.1_linux_amd64'  => '967ad75865b950698833eaf26415ba48d8a22befb5d4e8c77630ad70f251b100',
  '0.5.1_windows_386'  => 'bb9e1753cf793ad6f9db34bd6e18fb0fa5b0696a8a51a7f1c61484386dfe6682',
  '0.5.1_web_ui'       => 'ad883aa52e1c0136ab1492bbcedad1210235f26d59719fb6de3ef6464f1ff3b1',

  '0.5.2_darwin_amd64' => '87be515d7dbab760a61a359626a734f738d46ece367f68422b7dec9197d9eeea',
  '0.5.2_linux_386'    => '29306ce398109f954ceeea3af79878be4fb0d949f8af3a27c95ccef2101e8f60',
  '0.5.2_linux_amd64'  => '171cf4074bfca3b1e46112105738985783f19c47f4408377241b868affa9d445',
  '0.5.2_windows_386'  => '2e866812de16f1a6138a0fd1eebc76143f1314826e3b52597a55ac510ae94be6',
  '0.5.2_web_ui'       => 'ad883aa52e1c0136ab1492bbcedad1210235f26d59719fb6de3ef6464f1ff3b1'
}
