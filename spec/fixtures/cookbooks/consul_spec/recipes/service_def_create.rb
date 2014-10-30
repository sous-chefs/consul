consul_service_def "dummy" do
  id "uniqueid"
  port 8888
  tags ['releases', 'v1']
  check :interval => "10s", :script => "curl http://localhost:8888/health"
end
