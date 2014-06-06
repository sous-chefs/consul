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
default[:consul][:version] = '0.2.1'
default[:consul][:install_method] = 'binary'
default[:consul][:install_dir] = '/usr/local/bin'
default[:consul][:checksums] = {
  '0.2.1_darwin_amd64' => '5c9a952daf1f0ff3c11df5eacf87a03b67dabadf4a1a577f37af2ca6d3bfc7b6',
  '0.2.1_linux_386' => 'e95aee133c9a543769dbad3a8fa555863d8b2a2230ea0b15d72379aab532d4fc',
  '0.2.1_linux_amd64' => '0b4a91051c35acd86a8adc89b1c5d53c31cb3260eec88646cc47081729b0dbbf',
  '0.2.1_web_ui' => '3a8b00499002b56f101abecb2df3bd8ae6f417b776d76059aaeb42dded378ba0',
  '0.2.1_windows_386' => '9303da3f7725c55141840a9df3b1a5b097e4fab904f3f2180e14c65f1e02f15e'
}
default[:consul][:source_revision] = "master"

# Service attributes
default[:consul][:service_mode] = 'bootstrap'
default[:consul][:data_dir] = '/var/lib/consul'
default[:consul][:config_dir] = '/etc/consul.d'
default[:consul][:servers] = []

# UI attributes
default[:consul][:client_addr] = '0.0.0.0'
default[:consul][:ui_dir] = '/var/lib/consul/ui'
default[:consul][:serve_ui] = false
