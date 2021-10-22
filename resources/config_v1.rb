provides :consul_config
unified_mode true do |node|
  node['consul']['version'].to_i >= 1
end

# @!property path
# @return [String]
property :path, kind_of: String, name_property: true
# @!property owner
# @return [String]
property :owner, kind_of: String, default: lazy { node['consul']['service_user'] }
# @!property group
# @return [String]
property :group, kind_of: String, default: lazy { node['consul']['service_group'] }
# @!property config_dir
# @return [String]
property :config_dir, kind_of: String, default: lazy { node['consul']['service']['config_dir'] }
# @!property config_dir_mode
# @return [String]
property :config_dir_mode, kind_of: String, default: '0755'
# @!property options
# @return [Hash]
property :options, kind_of: Hash, default: {}

# @see: http://www.consul.io/docs/agent/options.html
property :acl, kind_of: [Hash, Mash]
property :acl_agent_token, kind_of: String
property :acl_agent_master_token, kind_of: String
property :acl_datacenter, kind_of: String
property :acl_default_policy, kind_of: String
property :acl_down_policy, kind_of: String
property :acl_enforce_version_8, kind_of: [TrueClass, FalseClass]
property :acl_master_token, kind_of: String
property :acl_replication_token, kind_of: String
property :acl_token, kind_of: String
property :acl_ttl, kind_of: String
property :addresses, kind_of: [Hash, Mash]
property :advertise_addr, kind_of: String
property :advertise_addr_ipv4, kind_of: String
property :advertise_addr_ipv6, kind_of: String
property :advertise_addr_wan, kind_of: String
property :advertise_addr_wan_ipv4, kind_of: String
property :advertise_addr_wan_ipv6, kind_of: String
property :atlas_acl_token, kind_of: String
property :atlas_infrastructure, kind_of: String
property :atlas_join, kind_of: [TrueClass, FalseClass]
property :atlas_token, kind_of: String
property :atlas_endpoint, kind_of: String
property :autopilot, kind_of: [Hash, Mash]
property :auto_encrypt, kind_of: [Hash, Mash]
property :bind_addr, kind_of: String
property :bootstrap, kind_of: [TrueClass, FalseClass]
property :bootstrap_expect, kind_of: Integer
property :ca_file, kind_of: String
property :ca_path, kind_of: String
property :cert_file, kind_of: String
property :check_update_interval, kind_of: String
property :client_addr, kind_of: String
property :config_entries, kind_of: [Hash, Mash]
property :connect, kind_of: [Hash, Mash]
property :data_dir, kind_of: String
property :datacenter, kind_of: String
property :disable_anonymous_signature, kind_of: [TrueClass, FalseClass]
property :disable_host_node_id, kind_of: [TrueClass, FalseClass]
property :disable_keyring_file, kind_of: [TrueClass, FalseClass]
property :disable_remote_exec, kind_of: [TrueClass, FalseClass]
property :disable_update_check, kind_of: [TrueClass, FalseClass]
property :discard_check_output, kind_of: [TrueClass, FalseClass]
property :discovery_max_stale, kind_of: String
property :dns_config, kind_of: [Hash, Mash]
property :domain, kind_of: String
property :enable_acl_replication, kind_of: [TrueClass, FalseClass]
property :enable_additional_node_meta_txt, kind_of: [TrueClass, FalseClass]
property :enable_agent_tls_for_checks, kind_of: [TrueClass, FalseClass]
property :enable_central_service_config, kind_of: [TrueClass, FalseClass]
property :enable_debug, kind_of: [TrueClass, FalseClass]
property :enable_local_script_checks, kind_of: [TrueClass, FalseClass]
property :enable_script_checks, kind_of: [TrueClass, FalseClass]
property :enable_syslog, kind_of: [TrueClass, FalseClass]
property :encrypt, kind_of: String
property :encrypt_verify_incoming, kind_of: [TrueClass, FalseClass]
property :encrypt_verify_outgoing, kind_of: [TrueClass, FalseClass]
property :gossip_lan, kind_of: [Hash, Mash]
property :gossip_wan, kind_of: [Hash, Mash]
property :http_api_response_headers, kind_of: [Hash, Mash]
property :http_config, kind_of: [Hash, Mash]
property :key_file, kind_of: String
property :leave_on_terminate, kind_of: [TrueClass, FalseClass]
property :limits, kind_of: [Hash, Mash]
property :log_file, kind_of: String
property :log_level, kind_of: String, equal_to: %w(INFO DEBUG WARN ERR)
property :log_rotate_duration, kind_of: String
property :log_rotate_bytes, kind_of: Integer
property :log_rotate_max_files, kind_of: Integer
property :metrics_prefix, kind_of: String
property :node_id, kind_of: String
property :node_name, kind_of: String
property :node_meta, kind_of: [Hash, Mash]
property :non_voting_server, kind_of: [TrueClass, FalseClass]
property :performance, kind_of: [Hash, Mash]
property :ports, kind_of: [Hash, Mash]
property :primary_datacenter, kind_of: String
property :protocol, kind_of: String
property :raft_protocol, kind_of: Integer
property :raft_snapshot_interval, kind_of: String
property :raft_snapshot_threshold, kind_of: Integer
property :raft_trailing_logs, kind_of: Integer
property :reap, kind_of: [TrueClass, FalseClass]
property :reconnect_timeout, kind_of: String
property :reconnect_timeout_wan, kind_of: String
property :recursor, kind_of: String
property :recursors, kind_of: Array
property :retry_interval, kind_of: String
property :retry_interval_wan, kind_of: String
property :retry_join, kind_of: Array
property :retry_join_azure, kind_of: [Hash, Mash]
property :retry_join_ec2, kind_of: [Hash, Mash]
property :retry_join_wan, kind_of: Array
property :retry_max, kind_of: Integer
property :rejoin_after_leave, kind_of: [TrueClass, FalseClass]
property :segment, kind_of: String
property :segments, kind_of: Array
property :serf_lan, kind_of: String
property :serf_wan, kind_of: String
property :serf_lan_bind, kind_of: String
property :serf_wan_bind, kind_of: String
property :server, kind_of: [TrueClass, FalseClass]
property :server_name, kind_of: String
property :session_ttl_min, kind_of: String
property :skip_leave_on_interrupt, kind_of: [TrueClass, FalseClass]
property :start_join, kind_of: Array
property :start_join_wan, kind_of: Array
property :statsd_addr, kind_of: String
property :statsd_address, kind_of: String
property :statsite_addr, kind_of: String
property :statsite_address, kind_of: String
property :statsite_prefix, kind_of: String
property :telemetry, kind_of: [Hash, Mash]
property :syslog_facility, kind_of: String
property :tls_cipher_suites, kind_of: String
property :tls_min_version, kind_of: String, equal_to: %w(tls10 tls11 tls12)
property :tls_prefer_server_cipher_suites, kind_of: [TrueClass, FalseClass]
property :translate_wan_addrs, kind_of: [TrueClass, FalseClass]
property :ui, kind_of: [TrueClass, FalseClass]
property :ui_dir, kind_of: String
property :unix_sockets, kind_of: [Hash, Mash]
property :verify_incoming, kind_of: [TrueClass, FalseClass]
property :verify_incoming_https, kind_of: [TrueClass, FalseClass]
property :verify_incoming_rpc, kind_of: [TrueClass, FalseClass]
property :verify_outgoing, kind_of: [TrueClass, FalseClass]
property :verify_server_hostname, kind_of: [TrueClass, FalseClass]
property :watches, kind_of: [Hash, Mash]

# Transforms the resource into a JSON format which matches the
# Consul service's configuration format.
def params_to_json
  for_keeps = %i(
  acl
  acl_agent_token
  acl_agent_master_token
  acl_datacenter
  acl_default_policy
  acl_down_policy
  acl_enforce_version_8
  acl_master_token
  acl_replication_token
  acl_token
  acl_ttl
  addresses
  advertise_addr
  advertise_addr_ipv4
  advertise_addr_ipv6
  advertise_addr_wan
  advertise_addr_wan_ipv4
  advertise_addr_wan_ipv6
  autopilot
  auto_encrypt
  bind_addr
  check_update_interval
  client_addr
  config_entries
  connect
  data_dir
  datacenter
  disable_anonymous_signature
  disable_host_node_id
  disable_keyring_file
  disable_remote_exec
  disable_update_check
  discard_check_output
  dns_config
  domain
  enable_acl_replication
  enable_additional_node_meta_txt
  enable_central_service_config
  enable_debug
  enable_local_script_checks
  enable_script_checks
  enable_syslog
  encrypt
  encrypt_verify_incoming
  encrypt_verify_outgoing
  gossip_lan
  gossip_wan
  http_config
  leave_on_terminate
  limits
  log_file
  log_level
  log_rotate_duration
  log_rotate_bytes
  log_rotate_max_files
  node_id
  node_meta
  node_name
  non_voting_server
  performance
  ports
  primary_datacenter
  protocol
  reap
  raft_protocol
  raft_snapshot_interval
  raft_snapshot_threshold
  raft_trailing_logs
  reconnect_timeout
  reconnect_timeout_wan
  recursors
  rejoin_after_leave
  retry_interval
  retry_interval_wan
  retry_join
  retry_join_wan
  retry_max
  segment
  segments
  serf_lan
  serf_wan
  serf_lan_bind
  serf_wan_bind
  server
  server_name
  session_ttl_min
  skip_leave_on_interrupt
  start_join
  start_join_wan
  syslog_facility
  telemetry
  tls_cipher_suites
  tls_min_version
  tls_prefer_server_cipher_suites
  translate_wan_addrs
  ui
  ui_dir
  unix_sockets
  verify_incoming
  verify_incoming_https
  verify_incoming_rpc
  verify_outgoing
  verify_server_hostname
  watches
  )

  for_keeps << %i(discovery_max_stale) if node['consul']['version'] > '1.0.6'
  for_keeps << %i(bootstrap bootstrap_expect) if server
  for_keeps << %i(ca_file ca_path cert_file enable_agent_tls_for_checks key_file) if tls?
  for_keeps = for_keeps.flatten

  raw_config = to_hash

  if raw_config[:retry_join_ec2]
    Chef::Log.warn("Parameter 'retry_join_ec2' is deprecated")
    join_string = consul_cloud_join_string('aws', retry_join_ec2)
    existing_retry_join = raw_config[:retry_join]
    raw_config[:retry_join] = if existing_retry_join.nil?
                                [join_string]
                              else
                                existing_retry_join.clone << join_string
                              end
  end
  if raw_config[:retry_join_azure]
    Chef::Log.warn("Parameter 'retry_join_azure' is deprecated")
    join_string = consul_cloud_join_string('azure', retry_join_azure)
    existing_retry_join = raw_config[:retry_join]
    raw_config[:retry_join] = if existing_retry_join.nil?
                                [join_string]
                              else
                                existing_retry_join.clone << join_string
                              end
  end
  [:atlas_infrastructure, :atlas_token, :atlas_acl_token, :atlas_join, :atlas_endpoint].each do |field|
    if raw_config[field]
      Chef::Log.warn("Parameter '#{field}' is deprecated")
    end
  end
  if raw_config[:http_api_response_headers]
    Chef::Log.warn("Parameter 'http_api_response_headers' is deprecated")
    raw_config[:http_config] = {
      'response_headers' => raw_config[:http_api_response_headers],
    }
  end
  if raw_config[:recursor]
    Chef::Log.warn("Parameter 'recursor' is deprecated")
    existing_recursors = raw_config[:recursors]
    raw_config[:recursors] = if existing_recursors.nil?
                               [raw_config[:recursor]]
                             else
                               existing_recursors.clone << raw_config[:recursor]
                             end
  end
  {
    statsd_addr: :statsd_address,
    statsite_addr: :statsite_address,
    statsite_prefix: :metrics_prefix,
  }.each do |field, replacement|
    next unless raw_config[field]
    Chef::Log.warn("Parameter '#{field}' is deprecated")
    raw_config[:telemetry] ||= {}
    raw_config[:telemetry][replacement] = raw_config[field]
  end

  # Filter out undefined attributes and keep only those listed above
  config = raw_config.keep_if do |k, v|
    !v.nil? && for_keeps.include?(k.to_sym)
  end.merge(options)
  JSON.pretty_generate(Hash[config.sort_by { |k, _| k.to_s }], quirks_mode: true)
end

def tls?
  verify_incoming || verify_outgoing
end

def consul_cloud_join_string(provider, values)
  "provider=#{provider} " << values.collect { |k, v| "#{k}=#{v}" }.join(' ')
end

action :create do
  [::File.dirname(new_resource.path), new_resource.config_dir].each do |dir|
    directory dir do
      recursive true
      unless platform?('windows')
        owner new_resource.owner
        group new_resource.group
        mode new_resource.config_dir_mode
      end
      not_if { dir == '/etc' }
    end
  end

  file new_resource.path do
    unless platform?('windows')
      owner new_resource.owner
      group new_resource.group
      mode '0640'
    end
    content new_resource.params_to_json
    sensitive true
  end
end

action :delete do
  file new_resource.path do
    action :delete
  end
end
