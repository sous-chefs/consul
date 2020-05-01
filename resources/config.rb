property :config_file, String, name_attribute: true
property :owner, String, default: 'root'
property :group, String, default: 'consul'
property :config_dir, String, default: '/etc/consul/conf.d'
property :options, option_collector: true

# @see: http://www.consul.io/docs/agent/options.html
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
property :advertise_addr_wan, String
property :atlas_acl_token, String
property :atlas_infrastructure, String
property :atlas_join, [true, false]
property :atlas_token, String
property :atlas_endpoint, String
property :autopilot, [Hash, Mash]
property :bind_addr, String
property :bootstrap, [true, false]
property :bootstrap_expect, Integer
property :ca_file, String
property :cert_file, String
property :check_update_interval, String
property :client_addr, String
property :data_dir, String
property :datacenter, String
property :disable_anonymous_signature, [true, false]
property :disable_host_node_id, [true, false]
property :disable_keyring_file, [true, false]
property :disable_remote_exec, [true, false]
property :disable_update_check, [true, false]
property :discovery_max_stale, String
property :dns_config, [Hash, Mash]
property :domain, String
property :enable_acl_replication, [true, false]
property :enable_debug, [true, false]
property :enable_script_checks, [true, false]
property :enable_syslog, [true, false]
property :encrypt, String
property :encrypt_verify_incoming, equal_to: [true, false]
property :encrypt_verify_outgoing, equal_to: [true, false]
property :http_api_response_headers, [Hash, Mash]
property :http_config, [Hash, Mash]
property :key_file, String
property :leave_on_terminate, equal_to: [true, false]
property :limits, [Hash, Mash]
property :log_level, equal_to: %w(INFO DEBUG WARN ERR)
property :node_id, String
property :node_name, String
property :node_meta, [Hash, Mash]
property :performance, [Hash, Mash]
property :ports, [Hash, Mash]
property :protocol, String
property :raft_protocol, Integer
property :reap, equal_to: [true, false]
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
property :serf_lan_bind, String
property :serf_wan_bind, String
property :server, [true, false]
property :server_name, String
property :session_ttl_min, String
property :skip_leave_on_interrupt, [true, false]
property :start_join, Array
property :start_join_wan, Array
property :statsd_addr, String
property :statsite_addr, String
property :statsite_prefix, String
property :telemetry, [Hash, Mash]
property :syslog_facility, String
property :tls_cipher_suites, String
property :tls_min_version, %w(tls10 tls11 tls12)
property :tls_prefer_server_cipher_suites, [true, false]
property :translate_wan_addrs, [true, false]
property :ui, [true, false]
property :ui_dir, String
property :unix_sockets, [Hash, Mash]
property :verify_incoming, [true, false]
property :verify_incoming_https, [true, false]
property :verify_outgoing, [true, false]
property :verify_server_hostname, [true, false]
property :watches, [Hash, Mash]

default_action :create

action :create do
  directory new_resource.config_dir do
    recursive true
    owner new_resource.owner
    group new_resource.group
    not_if { new_resource.config_dir == '/etc' }
  end

  template "#{new_resource.config_dir}/#{new_resource.config_file}" do
    source 'config.json.erb'
    cookbook 'consul'
    owner new_resource.owner
    group new_resource.group
    mode 0640
    variables(
      acl_agent_token: new_resource.acl_agent_token,
      acl_agent_master_token: new_resource.acl_agent_master_token,
      acl_datacenter: new_resource.acl_datacenter,
      acl_default_policy: new_resource.acl_default_policy,
      acl_down_policy: new_resource.acl_down_policy,
      acl_enforce_version_8: new_resource.acl_enforce_version_8,
      acl_master_token: new_resource.acl_master_token,
      acl_replication_token: new_resource.acl_replication_token,
      acl_token: new_resource.acl_token,
      acl_ttl: new_resource.acl_ttl,
      addresses: new_resource.addresses,
      advertise_addr: new_resource.advertise_addr,
      advertise_addr_wan: new_resource.advertise_addr_wan,
      atlas_acl_token: new_resource.atlas_acl_token,
      atlas_infrastructure: new_resource.atlas_infrastructure,
      atlas_join: new_resource.atlas_join,
      atlas_token: new_resource.atlas_token,
      atlas_endpoint: new_resource.atlas_endpoint,
      autopilot: new_resource.autopilot,
      bind_addr: new_resource.bind_addr,
      bootstrap: new_resource.bootstrap,
      bootstrap_expect: new_resource.bootstrap_expect,
      ca_file: new_resource.ca_file,
      cert_file: new_resource.cert_file,
      check_update_interval: new_resource.check_update_interval,
      client_addr: new_resource.client_addr,
      data_dir: new_resource.data_dir,
      datacenter: new_resource.datacenter,
      disable_anonymous_signature: new_resource.disable_anonymous_signature,
      disable_host_node_id: new_resource.disable_host_node_id,
      disable_keyring_file: new_resource.disable_keyring_file,
      disable_remote_exec: new_resource.disable_remote_exec,
      disable_update_check: new_resource.disable_update_check,
      discovery_max_stale: new_resource.discovery_max_stale,
      dns_config: new_resource.dns_config,
      domain: new_resource.domain,
      enable_acl_replication: new_resource.enable_acl_replication,
      enable_debug: new_resource.enable_debug,
      enable_script_checks: new_resource.enable_script_checks,
      enable_syslog: new_resource.enable_syslog,
      encrypt: new_resource.encrypt,
      encrypt_verify_incoming: new_resource.encrypt_verify_incoming,
      encrypt_verify_outgoing: new_resource.encrypt_verify_outgoing,
      http_api_response_headers: new_resource.http_api_response_headers,
      http_config: new_resource.http_config,
      key_file: new_resource.key_file,
      leave_on_terminate: new_resource.leave_on_terminate,
      limits: new_resource.limits,
      log_level: new_resource.log_level,
      node_id: new_resource.node_id,
      node_name: new_resource.node_name,
      node_meta: new_resource.node_meta,
      performance: new_resource.performance,
      ports: new_resource.ports,
      protocol: new_resource.protocol,
      raft_protocol: new_resource.raft_protocol,
      reap: new_resource.reap,
      reconnect_timeout: new_resource.reconnect_timeout,
      reconnect_timeout_wan: new_resource.reconnect_timeout_wan,
      recursor: new_resource.recursor,
      recursors: new_resource.recursors,
      retry_interval: new_resource.retry_interval,
      retry_interval_wan: new_resource.retry_interval_wan,
      retry_join: new_resource.retry_join,
      retry_join_azure: new_resource.retry_join_azure,
      retry_join_ec2: new_resource.retry_join_ec2,
      retry_join_wan: new_resource.retry_join_wan,
      retry_max: new_resource.retry_max,
      rejoin_after_leave: new_resource.rejoin_after_leave,
      serf_lan_bind: new_resource.serf_lan_bind,
      serf_wan_bind: new_resource.serf_wan_bind,
      server: new_resource.server,
      server_name: new_resource.server_name,
      session_ttl_min: new_resource.session_ttl_min,
      skip_leave_on_interrupt: new_resource.skip_leave_on_interrupt,
      start_join: new_resource.start_join,
      start_join_wan: new_resource.start_join_wan,
      statsd_addr: new_resource.statsd_addr,
      statsite_addr: new_resource.statsite_addr,
      statsite_prefix: new_resource.statsite_prefix,
      telemetry: new_resource.telemetry,
      syslog_facility: new_resource.syslog_facility,
      tls_cipher_suites: new_resource.tls_cipher_suites,
      tls_min_version: new_resource.tls_min_version,
      tls_prefer_server_cipher_suites: new_resource.tls_prefer_server_cipher_suites,
      translate_wan_addrs: new_resource.translate_wan_addrs,
      ui: new_resource.ui,
      ui_dir: new_resource.ui_dir,
      unix_sockets: new_resource.unix_sockets,
      verify_incoming: new_resource.verify_incoming,
      verify_incoming_https: new_resource.verify_incoming_https,
      verify_outgoing: new_resource.verify_outgoing,
      verify_server_hostname: new_resource.verify_server_hostname,
      watches: new_resource.watches,
    )
  end
end

action_class do
  include Consul::Cookbook::Helpers
end
