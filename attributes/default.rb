#
# Copyright 2014 John Bellone <jbellone@bloomberg.net>
# Copyright 2014 Bloomberg Finance L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['consul']['base_url']       = "https://dl.bintray.com/mitchellh/consul/%{version}.zip"
default['consul']['version']        = '0.5.2'
if node['platform_family'] == 'windows'
  default['consul']['version']      = '0.5.0'
end
default['consul']['install_method'] = 'binary'
default['consul']['install_dir']    = '/usr/local/bin'
default['consul']['choco_source']   = "https://chocolatey.org/api/v2/"

default['consul']['checksums'] = {
  '0.3.0_darwin_amd64' => '9dfbc70c01ebbc3e7dba0e4b31baeddbdcbd36ef99f5ac87ca6bbcc7405df405',
  '0.3.0_linux_386'    => '2513496374f8f15bda0da4da33122e93f82ce39f661ee3e668c67a5b7e98fd5f',
  '0.3.0_linux_amd64'  => 'da1337ab3b236bad19b791a54a8df03a8c2a340500a392000c21608696957b15',
  '0.3.0_web_ui'       => '0ab215e6aa7c94ccdb2c074732b8706940d37386b88c9421f1e4bc2501065476',
  '0.3.0_windows_386'  => '5d42e143eeb7c348ed8f7e15c6223e02ce0221dc0e076d15c8e6bdf88c8cd5d2',

  '0.3.1_darwin_amd64' => 'e310d54244b207702143f1667d61bf0147d1bd656a29496d8b58eea07078d1dc',
  '0.3.1_linux_386'    => '9b8340fdf464a99fc9dc108115602c761b703a16277fbd9f4f164123cf2a9f11',
  '0.3.1_linux_amd64'  => 'c33da8ac24f01eefe8549e8d4d301b4e18a71b61f06ae1377a88ccd6eab2cfbb',
  '0.3.1_web_ui'       => 'd8982803fffb84d3202260161f6310bd6bddb5b12bf690cf00210cd659a31ddd',
  '0.3.1_windows_386'  => '102bda6e02b193a9417e80795875bf7d18259fc5daff3d048d274beef690eb26',

  '0.4.0_darwin_amd64' => '87a1b0f37e773d92c939ca7dd6a50985acc4fb4aaec31384756ef896aef4035b',
  '0.4.0_linux_386'    => 'e2d494654cfed1b9248734f5cb9d34dba9f356dffdcc8a09ab0ab85d170dba7c',
  '0.4.0_linux_amd64'  => '4f8cd1cc5d90be9e1326fee03d3c96289a4f8b9b6ccb062d228125a1adc9ea0c',
  '0.4.0_windows_386'  => '895387de34352f29e8cb91066b44750a958d4a44a88ac39e164cf9c62b521b08',
  '0.4.0_web_ui'       => '0ee574e616864b658ba6ecf16db1183b63c5a4a36401880fb0404a2ea18536a6',

  '0.4.1_darwin_amd64' => '957fe9ba27bbaf99539cd534db8ac8ec4c9fa1c6b3b4675d0c0eb3a7fbfb646c',
  '0.4.1_linux_386'    => 'a496d6fd8ff5b460aea50be5d20fbd95cb5d30e9018259a0540273a17fae1c25',
  '0.4.1_linux_amd64'  => '2cf6e59edf348c3094c721eb77436e8c789afa2c35e6e3123a804edfeb1744ac',
  '0.4.1_windows_386'  => '61906f5d73a0d991dae5d75a25299f183670efa473cd155c715eefc98ce49cc8',
  '0.4.1_web_ui'       => 'e02929ed44f5392cadd5513bdc60b7ab7363d1670d59e64d2422123229962fa0',

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
  '0.5.2_web_ui'       => 'ad883aa52e1c0136ab1492bbcedad1210235f26d59719fb6de3ef6464f1ff3b1',
}
default['consul']['source_revision'] = 'master'
default['consul']['use_packagecloud_repo'] = true

# Service attributes
default['consul']['service_mode']  = 'bootstrap'
default['consul']['retry_on_join'] = false

# In the cluster mode, set the default cluster size to 3
default['consul']['bootstrap_expect'] = 3
default['consul']['data_dir'] = '/var/lib/consul'
default['consul']['config_dir'] = '/etc/consul.d'
default['consul']['logfile'] = '/var/log/consul.log'
default['consul']['init_style'] = 'init'   # 'init', 'runit', 'systemd'
case node['platform_family']
when 'windows'
  default['consul']['install_method'] = 'windows'
  default['consul']['init_style']     = 'windows'
  default['consul']['config_dir']     = "#{ENV['SystemDrive']}\\ProgramData\\consul\\config"
  default['consul']['data_dir']       = "#{ENV['SystemDrive']}\\ProgramData\\consul\\data"
  default['consul']['install_dir']    = "#{ChocolateyHelpers.chocolatey_install}\\lib\\consul.#{node['consul']['version']}"
  default['consul']['etc_config_dir'] = "#{ChocolateyHelpers.chocolatey_install}\\lib\\consul.#{node['consul']['version']}\\tools"
when 'debian'
  default['consul']['etc_config_dir'] = '/etc/default/consul'
when 'rhel'
  default['consul']['etc_config_dir'] = '/etc/sysconfig/consul'
else
  default['consul']['etc_config_dir'] = '/etc/sysconfig/consul'
end

default['consul']['servers'] = []

case node['consul']['init_style']
when 'runit' || 'systemd'
  default['consul']['service_user']  = 'consul'
  default['consul']['service_group'] = 'consul'
when 'windows'
  default['consul']['service_user']  = 'Administrator'
  default['consul']['service_group'] = 'Administrators'
else
  default['consul']['service_user']  = 'root'
  default['consul']['service_group'] = 'root'
end
default['consul']['system_account'] = false

default['consul']['ports'] = {
  'dns'      => 8600,
  'http'     => 8500,
  'rpc'      => 8400,
  'serf_lan' => 8301,
  'serf_wan' => 8302,
  "server"   => 8300,
}

# Ubuntu Upstart Open Files Limit
default['consul']['files_soft_limit'] = 2048
default['consul']['files_hard_limit'] = 4096

# Consul DataBag
default['consul']['data_bag']              = 'consul'
default['consul']['data_bag_encrypt_item'] = 'encrypt'

# Gossip encryption
default['consul']['encrypt_enabled'] = false
default['consul']['encrypt']         = nil
# TLS support
default['consul']['verify_incoming'] = false
default['consul']['verify_outgoing'] = false
# Cert in pem format
default['consul']['ca_cert']   = nil
default['consul']['ca_path']   = "%{config_dir}/ca.pem"
default['consul']['cert_file'] = nil
default['consul']['cert_path'] = "%{config_dir}/cert.pem"
# Cert in pem format. It can be unique for each host
default['consul']['key_file']      = nil
default['consul']['key_file_path'] = "%{config_dir}/key.pem"

# Optionally bind to a specific interface
default['consul']['bind_interface']      = nil
default['consul']['advertise_interface'] = nil
default['consul']['client_interface']    = nil

# UI attributes
default['consul']['client_addr']  = '0.0.0.0'
default['consul']['serve_ui']     = false
default['consul']['extra_params'] = {}

# Atlas support
default['consul']['atlas_autojoin'] = false
default['consul']['atlas_cluster'] = nil
default['consul']['atlas_token'] = nil

# Init script startup delay
default['consul']['startup_sleep'] = 3
