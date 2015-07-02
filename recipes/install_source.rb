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

include_recipe 'golang::default'

directory File.join(node['go']['gopath'], 'src/github.com/hashicorp') do
  owner 'root'
  group 'root'
  mode '00755'
  recursive true
  action :create
end

git File.join(node['go']['gopath'], '/src/github.com/hashicorp/consul') do
  repository 'https://github.com/hashicorp/consul.git'
  reference node['consul']['source_revision']
  action :checkout
end

golang_package 'github.com/hashicorp/consul' do
  action :install
end

directory File.basename(Chef::Consul.active_binary(node)) do
  recursive true
  action :create
end

link Chef::Consul.active_binary(node) do
  to Chef::Consul.source_binary(node)
end
