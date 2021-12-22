unified_mode true

default_action :create

property :url, String, default: 'http://localhost:8500'
property :auth_token, String, required: true
property :policy_name, String, name_property: true
property :description, String, default: ''
property :datacenters, Array, default: []
property :rules, String, default: ''
property :ssl, Hash, default: {}

def to_acl
  { 'Name' => policy_name,
    'Description' => description,
    'Datacenters' => datacenters,
    'Rules' => rules }
end

action :create do
  configure_diplomat
  unless up_to_date?
    policy = Diplomat::Policy.list.select { |p| p['Name'].downcase == new_resource.policy_name.downcase }
    if policy.empty?
      converge_by %(creating ACL policy "#{new_resource.policy_name.downcase}") do
        Diplomat::Policy.create(new_resource.to_acl)
      end
    else
      converge_by %(updating ACL policy "#{new_resource.policy_name.downcase}") do
        Diplomat::Policy.update(new_resource.to_acl.merge('ID' => policy.first['ID']))
      end
    end
  end
end

action :delete do
  configure_diplomat
  converge_by %(deleting ACL policy "#{new_resource.policy_name.downcase}") do
    policy = Diplomat::Policy.list.select { |p| p['Name'].downcase == new_resource.policy_name.downcase }
    Diplomat::Policy.delete(policy['ID']) unless policy.empty?
  end
end

action_class do
  include ConsulCookbook::ResourceHelpers

  def up_to_date?
    retry_block(max_tries: 3, sleep: 0.5) do
      old_policy_id = Diplomat::Policy.list.select { |p| p['Name'].downcase == new_resource.policy_name.downcase }
      return false if old_policy_id.empty?
      old_policy = Diplomat::Policy.read(old_policy_id.first['ID'], {}, :return)
      return false if old_policy.nil?
      old_policy.select! { |k, _v| %w(Name Description Datacenters Rules).include?(k) }
      old_policy['Description'].downcase!
      old_policy['Datacenters'] = [] unless old_policy.key?('Datacenters')
      old_policy == new_resource.to_acl
    end
  end
end
