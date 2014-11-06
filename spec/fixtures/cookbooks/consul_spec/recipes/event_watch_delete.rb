include_recipe "consul"
consul_event_watch_def "dummy" do
  action :delete
end
