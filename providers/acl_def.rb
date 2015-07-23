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

use_inline_resources if defined? use_inline_resources

action :create do
  ruby_block new_resource do
    data = {}
    data['Name'] = new_resource.name
    data['Type'] = new_resource.type
    data['Rules'] = new_resource.rules
    data['ID'] = new_resource.id unless new_resource.id.nil?
    block { client.create_acl(data) }
    only_if { !@current_resource || update_required? }
  end
end

action :delete do
  ruby_block new_resource do
    block { @client.delete_acl(@new_resource.name) }
    only_if { @current_resource }
  end
end

def client
  @client ||= Chef::Consul::Client.new(nil,node['consul']['ports']['http'],node['consul']['acl_master_token'])
end

def load_current_resource
  @current_resource = client.get_acl_by_name(@new_resource.name)
end

def update_required?
  @current_resource['Rules'] == @new_resource['Rules'] && @current_resource['Type'] == @new_resource['Type']
end
