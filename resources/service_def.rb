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
  'Checks must be a hash containing either a `:ttl` key/value or a `:script/:http` and `:interval` key/value' => ->(check) do
    Chef::Resource::ConsulServiceDef.validate_check(check)
  end
}

def self.validate_check(check)
  unless check.is_a?(Hash)
    return false
  end

  if check.key?(:ttl) && ( [:interval, :script, :http].none?{|key| check.key?(key)} )
    return true
  end

  if check.key?(:interval) && check.key?(:script)
    return true
  end

  if check.key?(:interval) && check.key?(:http)
    return true
  end

  false
end

def path
  ::File.join(node['consul']['config_dir'], "service-#{id || name}.json")
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
  hash[:service][:id]    = id unless id.nil?
  hash[:service][:port]  = port unless port.nil?
  hash[:service][:tags]  = tags unless tags.nil?
  hash[:service][:check] = check unless check.nil?
  hash
end
