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

attribute :service, name_attribute: true, required: true, kind_of: String
attribute :handler, required: true, kind_of: String
attribute :passingonly, required: false, kind_of: [TrueClass, FalseClass]
attribute :tag, required: false, kind_of: String

def path
  ::File.join(node['consul']['config_dir'], "service-watch-#{name}.json")
end

def to_json
  JSON.pretty_generate({'watches'=> [to_hash]})
end

def to_hash
  hash =  {
    type: "service"
  }
  hash[:service] = name
  hash[:handler] = handler unless handler.nil?
  hash[:tag] = tag unless tag.nil?
  hash[:passingonly] = passingonly unless passingonly.nil?
  hash
end
