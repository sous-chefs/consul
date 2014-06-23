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
attribute :port, kind_of: Integer
attribute :tags, kind_of: Array, default: nil
attribute :check, kind_of: Hash, default: nil, callbacks: {
  "Checks must be a hash containing either a `:ttl` key/value or a `:script` and `:interval` key/value" => ->(check) {
    Chef::Resource::ConsulServiceDef.validate_check(check)
  }
}

def self.validate_check(check)
  if !check.is_a?(Hash)
    return false
  end

  if check.has_key?(:ttl) && (!check.has_key?(:interval) && !check.has_key?(:script))
    return true
  end

  if check.has_key?(:interval) && check.has_key?(:script)
    return true
  end

  false
end

def path
  ::File.join(node[:consul][:config_dir], "service-#{name}.json")
end

def to_json
  JSON.pretty_generate(to_hash)
end

def to_hash
  hash = {
    service: {
      name: name
    }
  }
  hash[:service][:id]    = id if !id.nil?
  hash[:service][:port]  = port if !port.nil?
  hash[:service][:tags]  = tags if !tags.nil?
  hash[:service][:check] = check if !check.nil?
  hash
end
