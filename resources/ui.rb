#
# Copyright 2015 Sandor Acs <acs.sandor@ustream.tv>
# Copyright 2015 Ustream, Inc.
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

actions :create
default_action :create

attribute :base_url, :kind_of => String, :default => run_context.node['consul']['base_url'] 
attribute :version, :kind_of => String, :default => run_context.node['consul']['version']
attribute :checksums, :kind_of => String, :default => run_context.node['consul']['checksums']
attribute :data_dir, :kind_of => String, :default => run_context.node['consul']['data_dir']
attribute :config_dir, :kind_of => String, :default => run_context.node['consul']['config_dir']
attribute :ui_dir, :kind_of => String, :default => run_context.node['consul']['ui_dir']

attr_accessor :exists
