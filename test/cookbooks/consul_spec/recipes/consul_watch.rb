
# The ruby interpreter is guaranteed to exist since it's currently running.
file "/consul_watch_handler.rb" do
  content (<<-EOF).gsub(/^ */, '')
    #!#{RbConfig.ruby}
    exit 0
  EOF
  unless node.platform?('windows')
    owner 'root'
    mode '0755'
  end
end

consul_watch 'consul_watch_check' do
  type 'event'
  parameters(handler: "/consul_watch_handler.rb")
  notifies :reload, 'consul_service[consul]', :delayed
end
