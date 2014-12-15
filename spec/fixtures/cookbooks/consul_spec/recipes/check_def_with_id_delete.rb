include_recipe "consul"
consul_check_def "dummy name" do
  id "uniqueid"
  action :delete
end
