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

require 'json'

actions :create, :delete
default_action :create

attribute :name, name_attribute: true, required: true, kind_of: String
attribute :id, kind_of: String
attribute :script, kind_of: String
attribute :http, kind_of: String
attribute :ttl, kind_of: String
attribute :interval, kind_of: String
attribute :notes, kind_of: String

def path
  ::File.join(node['consul']['config_dir'], "check-#{id || name}.json")
end

def path_with_name
  ::File.join(node['consul']['config_dir'], "check-#{name}.json")
end

def to_json
  JSON.pretty_generate(to_hash)
end

def to_hash
  hash = {
    check: {
      name: name
    }
  }
  hash[:check][:id] = id unless id.nil?
  hash[:check][:script] = script unless script.nil?
  hash[:check][:ttl] = ttl unless ttl.nil?
  hash[:check][:http] = http unless http.nil?
  hash[:check][:interval] = interval unless interval.nil?
  hash[:check][:notes] = notes unless notes.nil?
  hash
end
