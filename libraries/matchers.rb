if defined?(ChefSpec)
  def create_consul_service_def(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_service_def, :create, resource_name)
  end

  def delete_consul_service_def(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_service_def, :delete, resource_name)
  end
end
