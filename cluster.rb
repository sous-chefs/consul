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
num_quorum = ENV.fetch('CONSUL_QUORUM', 3)

batch = machine_batch do
  1.upto(num_quorum).each do |index|
    machine "consul-#{index}" do
      recipe 'consul::default'
      attributes(consul: { service_mode: 'cluster' })
    end
  end
end

include_recipe 'chef-sugar::default'
node.default['consul']['servers'] = batch.machines.each { |m| best_ip_for(m.node) }

machine 'consul-ui' do
  recipe 'consul::ui'
  attributes(consul: {
    service_mode: 'client',
    servers: node['consul']['servers']
  })
end
