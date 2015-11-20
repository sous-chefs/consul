# Temp solution until some ChefSpec matchers are included in chocolatey

def install_chocolatey(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:chocolatey, :install, resource_name)
end

def remove_chocolatey(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:chocolatey, :remove, resource_name)
end
