include_recipe "consul"
consul_key_watch_def "dummy" do
  action :delete
end
