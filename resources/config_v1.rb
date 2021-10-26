provides :consul_config do |node|
  node['consul']['version'].to_i >= 1
end

unified_mode true

property :path, String, name_property: true
property :owner, String, default: lazy { node['consul']['service_user'] }
property :group, String, default: lazy { node['consul']['service_group'] }
property :config_dir, String, default: lazy { node['consul']['config_dir'] }
property :config_dir_mode, String, default: '0755'
property :options, Hash, default: {}

# @see: http://www.consul.io/docs/agent/options.html
property :acl, [Hash, Mash]
property :acl_agent_token, String
property :acl_agent_master_token, String
property :acl_datacenter, String
property :acl_default_policy, String
property :acl_down_policy, String
property :acl_enforce_version_8, [true, false]
property :acl_master_token, String
property :acl_replication_token, String
property :acl_token, String
property :acl_ttl, String
property :addresses, [Hash, Mash]
property :advertise_addr, String
property :advertise_addr_ipv4, String
property :advertise_addr_ipv6, String
property :advertise_addr_wan, String
property :advertise_addr_wan_ipv4, String
property :advertise_addr_wan_ipv6, String
property :atlas_acl_token, String
property :atlas_infrastructure, String
property :atlas_join, [true, false]
property :atlas_token, String
property :atlas_endpoint, String
property :autopilot, [Hash, Mash]
property :auto_encrypt, [Hash, Mash]
property :bind_addr, String
property :bootstrap, [true, false]
property :bootstrap_expect, Integer
property :ca_file, String
property :ca_path, String
property :cert_file, String
property :check_update_interval, String
property :client_addr, String
property :config_entries, [Hash, Mash]
property :connect, [Hash, Mash]
property :data_dir, String
property :datacenter, String
property :disable_anonymous_signature, [true, false]
property :disable_host_node_id, [true, false]
property :disable_keyring_file, [true, false]
property :disable_remote_exec, [true, false]
property :disable_update_check, [true, false]
property :discard_check_output, [true, false]
property :discovery_max_stale, String
property :dns_config, [Hash, Mash]
property :domain, String
property :enable_acl_replication, [true, false]
property :enable_additional_node_meta_txt, [true, false]
property :enable_agent_tls_for_checks, [true, false]
property :enable_central_service_config, [true, false]
property :enable_debug, [true, false]
property :enable_local_script_checks, [true, false]
property :enable_script_checks, [true, false]
property :enable_syslog, [true, false]
property :encrypt, String
property :encrypt_verify_incoming, [true, false]
property :encrypt_verify_outgoing, [true, false]
property :gossip_lan, [Hash, Mash]
property :gossip_wan, [Hash, Mash]
property :http_api_response_headers, [Hash, Mash]
property :http_config, [Hash, Mash]
property :key_file, String
property :leave_on_terminate, [true, false]
property :limits, [Hash, Mash]
property :log_file, String
property :log_level, String, equal_to: %w(INFO DEBUG WARN ERR)
property :log_rotate_duration, String
property :log_rotate_bytes, Integer
property :log_rotate_max_files, Integer
property :metrics_prefix, String
property :node_id, String
property :node_name, String
property :node_meta, [Hash, Mash]
property :non_voting_server, [true, false]
property :performance, [Hash, Mash]
property :ports, [Hash, Mash]
property :primary_datacenter, String
property :protocol, String
property :raft_protocol, Integer
property :raft_snapshot_interval, String
property :raft_snapshot_threshold, Integer
property :raft_trailing_logs, Integer
property :reap, [true, false]
property :reconnect_timeout, String
property :reconnect_timeout_wan, String
property :recursor, String
property :recursors, Array
property :retry_interval, String
property :retry_interval_wan, String
property :retry_join, Array
property :retry_join_azure, [Hash, Mash]
property :retry_join_ec2, [Hash, Mash]
property :retry_join_wan, Array
property :retry_max, Integer
property :rejoin_after_leave, [true, false]
property :segment, String
property :segments, Array
property :serf_lan, String
property :serf_wan, String
property :serf_lan_bind, String
property :serf_wan_bind, String
property :server, [true, false]
property :server_name, String
property :session_ttl_min, String
property :skip_leave_on_interrupt, [true, false]
property :start_join, Array
property :start_join_wan, Array
property :statsd_addr, String
property :statsd_address, String
property :statsite_addr, String
property :statsite_address, String
property :statsite_prefix, String
property :telemetry, [Hash, Mash]
property :syslog_facility, String
property :tls_cipher_suites, String
property :tls_min_version, String, equal_to: %w(tls10 tls11 tls12)
property :tls_prefer_server_cipher_suites, [true, false]
property :translate_wan_addrs, [true, false]
property :ui, [true, false]
property :ui_dir, String
property :unix_sockets, [Hash, Mash]
property :verify_incoming, [true, false]
property :verify_incoming_https, [true, false]
property :verify_incoming_rpc, [true, false]
property :verify_outgoing, [true, false]
property :verify_server_hostname, [true, false]
property :watches, [Hash, Mash]

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
