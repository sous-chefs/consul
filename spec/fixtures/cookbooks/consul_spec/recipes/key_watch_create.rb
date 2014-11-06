include_recipe "consul"
consul_key_watch_def "dummy" do
  key "/key/path"
  handler "chef-client"
end
