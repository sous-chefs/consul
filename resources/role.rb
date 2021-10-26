unified_mode true

default_action(:create)

property :url, String, default: 'http://localhost:8500'
property :auth_token, String, required: true
property :role_name, String, name_property: true
property :description, String, default: ''
property :policies, Array, default: []
property :service_identities, Array, default: []
property :ssl, Hash, default: {}

def to_acl
  { 'Name' => role_name,
    'Description' => description,
    'Policies' => policies,
    'ServiceIdentities' => service_identities }
end

action :create do
  configure_diplomat
  unless up_to_date?
    role = Diplomat::Role.list.select { |p| p['Name'] == new_resource.role_name }
    if role.empty?
      converge_by %(creating ACL role "#{new_resource.role_name}") do
        Diplomat::Role.create(new_resource.to_acl)
      end
    else
      converge_by %(updating ACL role "#{new_resource.role_name}") do
        Diplomat::Role.update(new_resource.to_acl.merge('ID' => role.first['ID']))
      end
    end
  end
end

action :delete do
  configure_diplomat
  converge_by %(deleting ACL role "#{new_resource.role_name}") do
    role = Diplomat::Role.list.select { |p| p['Name'] == new_resource.role_name }
    Diplomat::Role.delete(role['ID']) unless role.empty?
  end
end

action_class do
  include ConsulCookbook::ResourceHelpers

  def up_to_date?
    retry_block(max_tries: 3, sleep: 0.5) do
      old_role = Diplomat::Role.list.select { |p| p['Name'] == new_resource.role_name }.first
      return false if old_role.nil?
      old_role.select! { |k, _v| %w(Name Description Policies ServiceIdentities).include?(k) }
      old_role == new_resource.to_acl
    end
  end
end
