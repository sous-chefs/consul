include_recipe "consul"
consul_event_watch_def "dummy" do
  script "chef-client"
end
