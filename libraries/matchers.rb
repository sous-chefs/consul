if defined?(ChefSpec)
  %i{create delete}.each do |action|
    define_method(:"#{action}_consul_client") do |resource_name|
      ChefSpec::Matchers::ResourceMatcher.new(:consul_client, action, resource_name)
    end

    define_method(:"#{action}_consul_config") do |resource_name|
      ChefSpec::Matchers::ResourceMatcher.new(:consul_config, action, resource_name)
    end

    define_method(:"#{action}_consul_definition") do |resource_name|
      ChefSpec::Matchers::ResourceMatcher.new(:consul_definition, action, resource_name)
    end

    define_method(:"#{action}_consul_watch") do |resource_name|
      ChefSpec::Matchers::ResourceMatcher.new(:consul_watch, action, resource_name)
    end
  end

  %i{enable disable stop start restart reload}.each do |action|
    define_method(:"#{action}_consul_service") do |resource_name|
      ChefSpec::Matchers::ResourceMatcher.new(:consul_service, action, resource_name)
    end
  end
end
