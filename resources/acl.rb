unified_mode true

default_action :create

property :url, String, default: 'http://localhost:8500'
property :auth_token, String, required: true
property :id, String, name_property: true
property :acl_name, String, default: ''
property :type, String, equal_to: %w(client management), default: 'client'
property :rules, String, default: ''
property :ssl, Hash, default: {}

def to_acl
  { 'ID' => id,
    'Type' => type,
    'Name' => acl_name,
    'Rules' => rules }
end

action :create do
  configure_diplomat
  unless up_to_date?
    converge_by 'creating ACL' do
      Diplomat::Acl.create(new_resource.to_acl)
    end
  end
end

action :delete do
  configure_diplomat
  unless Diplomat::Acl.info(new_resource.id).empty?
    converge_by 'destroying ACL' do
      Diplomat::Acl.destroy(new_resource.id)
    end
  end
end

action_class do
  include ConsulCookbook::ResourceHelpers

  def up_to_date?
    retry_block(max_tries: 3, sleep: 0.5) do
      require 'diplomat/version'
      old_acl = if Diplomat::VERSION > '2.1.0'
                  Diplomat::Acl.info(new_resource.to_acl['ID'], {}, nil, :return)
                else
                  Diplomat::Acl.info(new_resource.to_acl['ID'], nil, :return)
                end
      return false if old_acl.nil? || old_acl.empty?
      old_acl.first.select! { |k, _v| %w(ID Type Name Rules).include?(k) }
      old_acl.first == new_resource.to_acl
    end
  end
end
