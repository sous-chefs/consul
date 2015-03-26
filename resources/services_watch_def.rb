require 'json'

actions :create, :delete
default_action :create

attribute :name, name_attribute: true, required: true, kind_of: String
attribute :handler, required: true, kind_of: String

def path
  ::File.join(node['consul']['config_dir'], "watch-services.json")
end

def to_json
  JSON.pretty_generate(to_hash)
end

def to_hash
  hash =  {
    watches:[
      {
        type: 'services',
        handler: handler
      }
    ]
  }
  hash
end
