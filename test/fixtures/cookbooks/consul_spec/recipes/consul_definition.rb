# The ruby interpreter is guaranteed to exist since it's currently running.
file '/consul_definition_check.rb' do
  content <<-EOF.gsub(/^ */, '')
    /bin/sh -c 'echo "Consul check script invoked"'
  EOF
  unless node.platform?('windows')
    owner 'root'
    mode '0755'
  end
end

consul_definition 'consul_definition_check' do
  type 'check'
  user 'root'
  parameters(id: 'consul_definition_check',
             script: '/consul_definition_check.rb',
             interval: '10s',
             timeout: '10s')
  notifies :reload, 'consul_service[consul]', :delayed
end
