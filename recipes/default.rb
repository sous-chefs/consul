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

consul_agent 'default' do
end

# Testing
# consul_agent 'custom' do
#   install_method 'source'
#   init_style 'runit'
#   serve_ui true
#   data_dir '/tmp/consul_data_dir'
#   config_dir '/tmp/consul_config_dir'
#   bind_interface 'eth1'
#   advertise_interface 'eth1'
#   client_interface 'eth1'
#     ports ({
#       'dns'      => 18609,
#       'http'     => 18509,
#       'rpc'      => 18409,
#       'serf_lan' => 18315,
#       'serf_wan' => 18316,
#       'server'   => 18317,
#      })
#   datacenter 'test_dc'
# end

# consul_ui 'custom' do
#     data_dir '/tmp/consul_data_dir'
#     config_dir '/tmp/consul_config_dir'
#     ui_dir '/tmp/consul_ui_dir'
# end
