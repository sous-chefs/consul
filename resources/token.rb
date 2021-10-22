unified_mode true

default_action(:create)

# @!property url
# @return [String]
property :url, kind_of: String, default: 'http://localhost:8500'

# @!property auth_token
# @return [String]
property :auth_token, kind_of: String, required: true

# @!property secret_id
# @return [String]
property :secret_id, kind_of: String, default: nil

# @!property description
# @return [String]
property :description, kind_of: String, name_property: true

# @!property policies
# @return [Array]
property :policies, kind_of: Array, default: []

# @!property roles
# @return [Array]
property :roles, kind_of: Array, default: []

# @!property service_identities
# @return [Array]
property :service_identities, kind_of: Array, default: []

# @!property expiration_time
# @return [String]
property :expiration_time, kind_of: String, default: ''

# @!property expiration_ttl
# @return [String]
property :expiration_ttl, kind_of: String, default: nil

# @!property local
# @return [Bool]
property :local, kind_of: [TrueClass, FalseClass], default: false

# @!property ssl
# @return [Hash]
property :ssl, kind_of: Hash, default: {}

def to_acl
  { 'SecretID' => secret_id,
    'Description' => description.downcase,
    'Local' => local,
    'Policies' => [ policies.each_with_object({}) { |k, h| h['Name'] = k } ],
  }
end

action :create do
  configure_diplomat
  unless up_to_date?
    old_token = Diplomat::Token.list.select { |p| p['Description'].downcase == new_resource.description.downcase }
    if old_token.empty?
      converge_by %(creating ACL token "#{new_resource.description.downcase}") do
        Diplomat::Token.create(new_resource.to_acl)
      end
    else
      converge_by %(updating ACL token "#{new_resource.description.downcase}") do
        Diplomat::Token.update(new_resource.to_acl.merge('AccessorID' => old_token.first['AccessorID']))
      end
    end
  end
end

action :delete do
  configure_diplomat
  converge_by %(deleting ACL token "#{new_resource.description.downcase}") do
    token = Diplomat::Token.list.select { |p| p['Description'].downcase == new_resource.description.downcase }
    Diplomat::Token.delete(token['AccessorID']) unless token.empty?
  end
end

action_class do
  include ConsulCookbook::ResourceHelpers

  def up_to_date?
    retry_block(max_tries: 3, sleep: 0.5) do
      old_token_id = Diplomat::Token.list.select { |p| p['Description'].downcase == new_resource.description.downcase }
      if old_token_id.empty?
        Chef::Log.warn %(Token with description "#{new_resource.description.downcase}" was not found. Will create.)
        return false
      end
      old_token = Diplomat::Token.read(old_token_id.first['AccessorID'], {}, :return)
      old_token.select! { |k, _v| %w(SecretID Description Policies Local).include?(k) }
      old_token['Description'].downcase!
      old_token == new_resource.to_acl
    end
  end
end
