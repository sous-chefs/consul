include_recipe "consul"
consul_check_def "dummy name" do
  action :delete
end
