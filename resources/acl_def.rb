require 'json'

actions :create, :delete
default_action :create

attribute :name, name_attribute: true, required: true, kind_of: String
attribute :rules, kind_of: String
attribute :id, kind_of: String
attribute :type, kind_of: String, default: "client", required: true
