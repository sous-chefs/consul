if defined?(ChefSpec)
  def create_consul_client(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_client, :create, resource_name)
  end

  def delete_consul_client(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_client, :delete, resource_name)
  end

  def create_consul_config(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_config, :create, resource_name)
  end

  def delete_consul_config(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_config, :delete, resource_name)
  end

  def create_consul_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_service, :create, resource_name)
  end

  def delete_consul_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_service, :delete, resource_name)
  end

  def start_consul_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_service, :start, resource_name)
  end

  def stop_consul_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_service, :stop, resource_name)
  end

  def restart_consul_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_service, :restart, resource_name)
  end

  def reload_consul_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_service, :reload, resource_name)
  end

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
