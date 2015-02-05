if defined?(ChefSpec)
  def create_consul_service_def(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_service_def, :create, resource_name)
  end

  def delete_consul_service_def(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_service_def, :delete, resource_name)
  end

  def create_consul_event_watch_def(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_event_watch_def, :create, resource_name)
  end

  def delete_consul_key_watch_def(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_key_watch_def, :create, resource_name)
  end
end
