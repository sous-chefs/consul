#
# Cookbook Name:: consul
# Author:: John Bellone <jbellone@bloomberg.net>
#
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
default[:consul][:version] = '0.1.0'
default[:consul][:checksums] = {
  '0.1.0_darwin_amd64' => '7989af75d1bbd43a4dff8f440c9a0883a4bcd66a52d94534f94e1ed1ae219681',
  '0.1.0_linux_386' => 'f822439eeb0f2d3a8d69ae42fdd13d8eaaa40b370dcdb7d41187433ec5b2961d',
  '0.1.0_linux_amd64' => '80912eb136acf5ac6ba77284138e4536cd1289870f202ed17ed67bbf2c6b630c',
  '0.1.0_windows_386' => '8757e01531df888128c9c1be4735acb80954e4b14a775718b3cff569c6e5e5b0'
}
