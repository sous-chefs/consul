# Copyright 2014 Benny Wong <benny@bwong.net>
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

include_recipe 'ark::default'

install_version = [node['consul']['version'], 'web_ui'].join('_')
install_checksum = node['consul']['checksums'].fetch(install_version)

ark 'consul_ui' do
  path node['consul']['data_dir']
  home_dir node['consul']['ui_dir']
  version node['consul']['version']
  checksum install_checksum
  url ::URI.join(node['consul']['base_url'], "#{install_version}.zip").to_s
end
