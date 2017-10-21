#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise'
require_relative 'helpers'

module ConsulCookbook
  module Resource
    # @since 1.0
    class ConsulConfig < Chef::Resource
      include Poise(fused: true)
      include ConsulCookbook::Helpers
      provides(:consul_config)

      # @!attribute path
      # @return [String]
      attribute(:path, kind_of: String, name_attribute: true)
      # @!attribute owner
      # @return [String]
      attribute(:owner, kind_of: String, default: lazy { node['consul']['service_user'] })
      # @!attribute group
      # @return [String]
      attribute(:group, kind_of: String, default: lazy { node['consul']['service_group'] })
      # @!attribute config_dir
      # @return [String]
      attribute(:config_dir, kind_of: String, default: lazy { node['consul']['service']['config_dir'] })
      # @!attribute config_dir_mode
      # @return [String]
      attribute(:config_dir_mode, kind_of: String, default: '0755')
      # @!attribute options
      # @return [Hash]
      attribute(:options, option_collector: true)

      # @see: http://www.consul.io/docs/agent/options.html
      attribute(:acl_agent_token, kind_of: String)
      attribute(:acl_agent_master_token, kind_of: String)
      attribute(:acl_datacenter, kind_of: String)
      attribute(:acl_default_policy, kind_of: String)
      attribute(:acl_down_policy, kind_of: String)
      attribute(:acl_enforce_version_8, equal_to: [true, false])
      attribute(:acl_master_token, kind_of: String)
      attribute(:acl_replication_token, kind_of: String)
      attribute(:acl_token, kind_of: String)
      attribute(:acl_ttl, kind_of: String)
      attribute(:addresses, kind_of: [Hash, Mash])
      attribute(:advertise_addr, kind_of: String)
      attribute(:advertise_addr_wan, kind_of: String)
      attribute(:atlas_acl_token, kind_of: String)
      attribute(:atlas_infrastructure, kind_of: String)
      attribute(:atlas_join, equal_to: [true, false])
      attribute(:atlas_token, kind_of: String)
      attribute(:atlas_endpoint, kind_of: String)
      attribute(:autopilot, kind_of: [Hash, Mash])
      attribute(:bind_addr, kind_of: String)
      attribute(:bootstrap, equal_to: [true, false])
      attribute(:bootstrap_expect, kind_of: Integer)
      attribute(:ca_file, kind_of: String)
      attribute(:cert_file, kind_of: String)
      attribute(:check_update_interval, kind_of: String)
      attribute(:client_addr, kind_of: String)
      attribute(:data_dir, kind_of: String)
      attribute(:datacenter, kind_of: String)
      attribute(:disable_anonymous_signature, equal_to: [true, false])
      attribute(:disable_host_node_id, equal_to: [true, false])
      attribute(:disable_keyring_file, equal_to: [true, false])
      attribute(:disable_remote_exec, equal_to: [true, false])
      attribute(:disable_update_check, equal_to: [true, false])
      attribute(:dns_config, kind_of: [Hash, Mash])
      attribute(:domain, kind_of: String)
      attribute(:enable_acl_replication, equal_to: [true, false])
      attribute(:enable_debug, equal_to: [true, false])
      attribute(:enable_script_checks, equal_to: [true, false])
      attribute(:enable_syslog, equal_to: [true, false])
      attribute(:encrypt, kind_of: String)
      attribute(:encrypt_verify_incoming, equal_to: [true, false])
      attribute(:encrypt_verify_outgoing, equal_to: [true, false])
      attribute(:http_api_response_headers, kind_of: [Hash, Mash])
      attribute(:http_config, kind_of: [Hash, Mash])
      attribute(:key_file, kind_of: String)
      attribute(:leave_on_terminate, equal_to: [true, false])
      attribute(:limits, kind_of: [Hash, Mash])
      attribute(:log_level, equal_to: %w(INFO DEBUG WARN ERR))
      attribute(:node_id, kind_of: String)
      attribute(:node_name, kind_of: String)
      attribute(:node_meta, kind_of: [Hash, Mash])
      attribute(:performance, kind_of: [Hash, Mash])
      attribute(:ports, kind_of: [Hash, Mash])
      attribute(:protocol, kind_of: String)
      attribute(:raft_protocol, kind_of: Integer)
      attribute(:reap, equal_to: [true, false])
      attribute(:reconnect_timeout, kind_of: String)
      attribute(:reconnect_timeout_wan, kind_of: String)
      attribute(:recursor, kind_of: String)
      attribute(:recursors, kind_of: Array)
      attribute(:retry_interval, kind_of: String)
      attribute(:retry_interval_wan, kind_of: String)
      attribute(:retry_join, kind_of: Array)
      attribute(:retry_join_ec2, kind_of: [Hash, Mash])
      attribute(:retry_join_wan, kind_of: Array)
      attribute(:retry_max, kind_of: Integer)
      attribute(:rejoin_after_leave, equal_to: [true, false])
      attribute(:serf_lan_bind, kind_of: String)
      attribute(:serf_wan_bind, kind_of: String)
      attribute(:server, equal_to: [true, false])
      attribute(:server_name, kind_of: String)
      attribute(:session_ttl_min, kind_of: String)
      attribute(:skip_leave_on_interrupt, equal_to: [true, false])
      attribute(:start_join, kind_of: Array)
      attribute(:start_join_wan, kind_of: Array)
      attribute(:statsd_addr, kind_of: String)
      attribute(:statsite_addr, kind_of: String)
      attribute(:statsite_prefix, kind_of: String)
      attribute(:telemetry, kind_of: [Hash, Mash])
      attribute(:syslog_facility, kind_of: String)
      attribute(:tls_cipher_suites, kind_of: Array)
      attribute(:tls_min_version, equal_to: %w(tls10 tls11 tls12))
      attribute(:tls_prefer_server_cipher_suites, equal_to: [true, false])
      attribute(:translate_wan_addrs, equal_to: [true, false])
      attribute(:ui, equal_to: [true, false])
      attribute(:ui_dir, kind_of: String)
      attribute(:unix_sockets, kind_of: [Hash, Mash])
      attribute(:verify_incoming, equal_to: [true, false])
      attribute(:verify_incoming_https, equal_to: [true, false])
      attribute(:verify_outgoing, equal_to: [true, false])
      attribute(:verify_server_hostname, equal_to: [true, false])
      attribute(:watches, kind_of: [Hash, Mash])

      # Transforms the resource into a JSON format which matches the
      # Consul service's configuration format.
      def to_json
        for_keeps = %i(
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
          advertise_addr_wan
          atlas_acl_token
          atlas_endpoint
          atlas_infrastructure
          atlas_join
          atlas_token
          autopilot
          bind_addr
          check_update_interval
          client_addr
          data_dir
          datacenter
          disable_anonymous_signature
          disable_host_node_id
          disable_keyring_file
          disable_remote_exec
          disable_update_check
          dns_config
          domain
          enable_acl_replication
          enable_debug
          enable_script_checks
          enable_syslog
          encrypt
          encrypt_verify_incoming
          encrypt_verify_outgoing
          http_api_response_headers
          http_config
          leave_on_terminate
          limits
          log_level
          node_id
          node_meta
          node_name
          performance
          ports
          protocol
          reap
          raft_protocol
          reconnect_timeout
          reconnect_timeout_wan
          recursor
          recursors
          rejoin_after_leave
          retry_interval
          retry_interval_wan
          retry_join
          retry_join_ec2
          retry_join_wan
          retry_max
          serf_lan_bind
          serf_wan_bind
          server
          server_name
          session_ttl_min
          skip_leave_on_interrupt
          start_join
          start_join_wan
          statsd_addr
          statsite_addr
          statsite_prefix
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
          verify_outgoing
          verify_server_hostname
          watches
        )

        for_keeps << %i(bootstrap bootstrap_expect) if server
        for_keeps << %i(ca_file cert_file key_file) if tls?
        for_keeps = for_keeps.flatten

        # Filter out undefined attributes and keep only those listed above
        config = to_hash.keep_if do |k, v|
          !v.nil? && for_keeps.include?(k.to_sym)
        end.merge(options)
        JSON.pretty_generate(Hash[config.sort_by { |k, _| k.to_s }], quirks_mode: true)
      end

      def tls?
        verify_incoming || verify_outgoing
      end

      action(:create) do
        notifying_block do
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
            content new_resource.to_json
            sensitive true
          end
        end
      end

      action(:delete) do
        notifying_block do
          file new_resource.path do
            action :delete
          end
        end
      end
    end
  end
end
