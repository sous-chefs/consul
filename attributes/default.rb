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
default[:consul][:version] = '0.2.0'
default[:consul][:install_method] = 'binary'
default[:consul][:install_dir] = '/usr/local/bin'
default[:consul][:checksums] = {
  '0.2.0_darwin_amd64' => '0a03a42fa3ea945d19152bc2429b4098a195a68f7a8f10a1b63e805f7f251fe9',
  '0.2.0_linux_386' => '564d6d8837c0db3efc4848bd85fad7911a291fcd948e74deae4d9ac6ce2a4637',
  '0.2.0_linux_amd64' => '2802ce8e173ee37e1a1e992ba230963e09d4b41ce4ac60c1222714c036787b4f',
  '0.2.0_windows_386' => '353da0b0321293d81a1e2351b7bc6902d462c6573e44a4495d1a61df6b0a0179'
}
repository node[:consul][:source_revision] = "master"

# Service attributes
default[:consul][:service_mode] = 'bootstrap'
default[:consul][:data_dir] = '/var/lib/consul'
default[:consul][:servers] = []
