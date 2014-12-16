include_recipe "consul"
consul_check_def "dummy name" do
  script "curl http://localhost:8888/health"
  interval "10s"
  ttl "50s"
  notes "Blahblah"
end
