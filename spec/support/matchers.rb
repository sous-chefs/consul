%w{start enable stop disable}.each do |action|
  define_method(:"#{action}_runit_service") do |name|
    ChefSpec::Matchers::ResourceMatcher.new(:runit_service, action.to_sym, name)
  end
end

%w{install uninstall}.each do |action|
  define_method(:"#{action}_golang_package") do |name|
    ChefSpec::Matchers::ResourceMatcher.new(:golang_package, action.to_sym, name)
  end
end

%w{put dump}.each do |action|
  define_method(:"#{action}_ark") do |name|
    ChefSpec::Matchers::ResourceMatcher.new(:ark, action.to_sym, name)
  end
end
