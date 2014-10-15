def start_runit_service(name)
  ChefSpec::Matchers::ResourceMatcher.new(:runit_service, :start, name)
end

def stop_runit_service(name)
  ChefSpec::Matchers::ResourceMatcher.new(:runit_service, :stop, name)
end

def enable_runit_service(name)
  ChefSpec::Matchers::ResourceMatcher.new(:runit_service, :enable, name)
end

def disable_runit_service(name)
  ChefSpec::Matchers::ResourceMatcher.new(:runit_service, :disable, name)
end

def install_golang_package(name)
  ChefSpec::Matchers::ResourceMatcher.new(:golang_package, :install, name)
end

def uninstall_golang_package(name)
  ChefSpec::Matchers::ResourceMatcher.new(:golang_package, :uninstall, name)
end

def put_ark(name)
  ChefSpec::Matchers::ResourceMatcher.new(:ark, :put, name)
end

def dump_ark(name)
  ChefSpec::Matchers::ResourceMatcher.new(:ark, :dump, name)
end

def install_ark(name)
  ChefSpec::Matchers::ResourceMatcher.new(:ark, :install, name)
end
