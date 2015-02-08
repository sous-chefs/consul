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

user node['consul']['service_user'] do
  system true
  home '/dev/null'
  shell '/bin/false'
  not_if { username == 'root' }
end

group node['consul']['service_group'] do
  system true
  members node['consul']['service_user']
  not_if { group_name == 'root' }
end

consul_config node['consul']['config_dir'] do
  user node['consul']['service_user']
  group node['consul']['service_group']
end

consul_client File.join(node['consul']['install_dir'], 'consul') do
  provider Chef::Provider::ConsulClientBinary if node['consul']['install_method'] == 'binary'
  provider Chef::Provider::ConsulClientSource if node['consul']['install_method'] == 'source'
end

consul_service 'consul' do
  action :start
end
