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

default[:consul][:base_url] = 'https://dl.bintray.com/mitchellh/consul/'
default[:consul][:version] = '0.3.0'
default[:consul][:install_method] = 'binary'
default[:consul][:install_dir] = '/usr/local/bin'
default[:consul][:checksums] = {
  "0.3.0_darwin_amd64" => "9dfbc70c01ebbc3e7dba0e4b31baeddbdcbd36ef99f5ac87ca6bbcc7405df405",
  "0.3.0_linux_386"    => "2513496374f8f15bda0da4da33122e93f82ce39f661ee3e668c67a5b7e98fd5f",
  "0.3.0_linux_amd64"  => "da1337ab3b236bad19b791a54a8df03a8c2a340500a392000c21608696957b15",
  "0.3.0_web_ui"       => "0ab215e6aa7c94ccdb2c074732b8706940d37386b88c9421f1e4bc2501065476",
  "0.3.0_windows_386"  => "5d42e143eeb7c348ed8f7e15c6223e02ce0221dc0e076d15c8e6bdf88c8cd5d2"
}
default[:consul][:source_revision] = "master"

# Service attributes
default[:consul][:service_mode] = 'bootstrap'
default[:consul][:data_dir] = '/var/lib/consul'
default[:consul][:config_dir] = '/etc/consul.d'
default[:consul][:servers] = []
default[:consul][:init_style] = 'init'   # 'init', 'runit'
default[:consul][:service_user] = 'consul'
default[:consul][:service_group] = 'consul'

# UI attributes
default[:consul][:client_addr] = '0.0.0.0'
default[:consul][:ui_dir] = '/var/lib/consul/ui'
default[:consul][:serve_ui] = false
