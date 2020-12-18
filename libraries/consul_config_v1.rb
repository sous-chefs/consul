#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright:: 2014-2016, Bloomberg Finance L.P.
#
require 'poise'
require_relative 'helpers'

module ConsulCookbook
  module Resource
    # @since 1.0
    class ConsulConfigV1 < Chef::Resource
      include Poise(fused: true)
      include ConsulCookbook::Helpers
      provides :consul_config do |node|
        node['consul']['version'].to_i >= 1
      end

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
      attribute(:acl, kind_of: [Hash, Mash])
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
      attribute(:auto_encrypt, kind_of: [Hash, Mash])
      attribute(:bind_addr, kind_of: String)
      attribute(:bootstrap, equal_to: [true, false])
      attribute(:bootstrap_expect, kind_of: Integer)
      attribute(:ca_file, kind_of: String)
      attribute(:ca_path, kind_of: String)
      attribute(:cert_file, kind_of: String)
      attribute(:check_update_interval, kind_of: String)
      attribute(:client_addr, kind_of: String)
      attribute(:config_entries, kind_of: [Hash, Mash])
      attribute(:connect, kind_of: [Hash, Mash])
      attribute(:data_dir, kind_of: String)
      attribute(:datacenter, kind_of: String)
      attribute(:disable_anonymous_signature, equal_to: [true, false])
      attribute(:disable_host_node_id, equal_to: [true, false])
      attribute(:disable_keyring_file, equal_to: [true, false])
      attribute(:disable_remote_exec, equal_to: [true, false])
      attribute(:disable_update_check, equal_to: [true, false])
      attribute(:discard_check_output, equal_to: [true, false])
      attribute(:discovery_max_stale, kind_of: String)
      attribute(:dns_config, kind_of: [Hash, Mash])
      attribute(:domain, kind_of: String)
      attribute(:enable_acl_replication, equal_to: [true, false])
      attribute(:enable_agent_tls_for_checks, equal_to: [true, false])
      attribute(:enable_central_service_config, equal_to: [true, false])
      attribute(:enable_debug, equal_to: [true, false])
      attribute(:enable_local_script_checks, equal_to: [true, false])
      attribute(:enable_script_checks, equal_to: [true, false])
      attribute(:enable_syslog, equal_to: [true, false])
      attribute(:encrypt, kind_of: String)
      attribute(:encrypt_verify_incoming, equal_to: [true, false])
      attribute(:encrypt_verify_outgoing, equal_to: [true, false])
      attribute(:gossip_lan, kind_of: [Hash, Mash])
      attribute(:gossip_wan, kind_of: [Hash, Mash])
      attribute(:http_api_response_headers, kind_of: [Hash, Mash])
      attribute(:http_config, kind_of: [Hash, Mash])
      attribute(:key_file, kind_of: String)
      attribute(:leave_on_terminate, equal_to: [true, false])
      attribute(:limits, kind_of: [Hash, Mash])
      attribute(:log_file, kind_of: String)
      attribute(:log_level, equal_to: %w(INFO DEBUG WARN ERR))
      attribute(:log_rotate_duration, kind_of: String)
      attribute(:log_rotate_bytes, kind_of: Integer)
      attribute(:log_rotate_max_files, kind_of: Integer)
      attribute(:metrics_prefix, kind_of: String)
      attribute(:node_id, kind_of: String)
      attribute(:node_name, kind_of: String)
      attribute(:node_meta, kind_of: [Hash, Mash])
      attribute(:non_voting_server, equal_to: [true, false])
      attribute(:performance, kind_of: [Hash, Mash])
      attribute(:ports, kind_of: [Hash, Mash])
      attribute(:primary_datacenter, kind_of: String)
      attribute(:protocol, kind_of: String)
      attribute(:raft_protocol, kind_of: Integer)
      attribute(:raft_snapshot_interval, kind_of: String)
      attribute(:raft_snapshot_threshold, kind_of: Integer)
      attribute(:raft_trailing_logs, kind_of: Integer)
      attribute(:reap, equal_to: [true, false])
      attribute(:reconnect_timeout, kind_of: String)
      attribute(:reconnect_timeout_wan, kind_of: String)
      attribute(:recursor, kind_of: String)
      attribute(:recursors, kind_of: Array)
      attribute(:retry_interval, kind_of: String)
      attribute(:retry_interval_wan, kind_of: String)
      attribute(:retry_join, kind_of: Array)
      attribute(:retry_join_azure, kind_of: [Hash, Mash])
      attribute(:retry_join_ec2, kind_of: [Hash, Mash])
      attribute(:retry_join_wan, kind_of: Array)
      attribute(:retry_max, kind_of: Integer)
      attribute(:rejoin_after_leave, equal_to: [true, false])
      attribute(:segment, kind_of: String)
      attribute(:segments, kind_of: Array)
      attribute(:serf_lan, kind_of: String)
      attribute(:serf_wan, kind_of: String)
      attribute(:serf_lan_bind, kind_of: String)
      attribute(:serf_wan_bind, kind_of: String)
      attribute(:server, equal_to: [true, false])
      attribute(:server_name, kind_of: String)
      attribute(:session_ttl_min, kind_of: String)
      attribute(:skip_leave_on_interrupt, equal_to: [true, false])
      attribute(:start_join, kind_of: Array)
      attribute(:start_join_wan, kind_of: Array)
      attribute(:statsd_addr, kind_of: String)
      attribute(:statsd_address, kind_of: String)
      attribute(:statsite_addr, kind_of: String)
      attribute(:statsite_address, kind_of: String)
      attribute(:statsite_prefix, kind_of: String)
      attribute(:telemetry, kind_of: [Hash, Mash])
      attribute(:syslog_facility, kind_of: String)
      attribute(:tls_cipher_suites, kind_of: String)
      attribute(:tls_min_version, equal_to: %w(tls10 tls11 tls12))
      attribute(:tls_prefer_server_cipher_suites, equal_to: [true, false])
      attribute(:translate_wan_addrs, equal_to: [true, false])
      attribute(:ui, equal_to: [true, false])
      attribute(:ui_dir, kind_of: String)
      attribute(:unix_sockets, kind_of: [Hash, Mash])
      attribute(:verify_incoming, equal_to: [true, false])
      attribute(:verify_incoming_https, equal_to: [true, false])
      attribute(:verify_incoming_rpc, equal_to: [true, false])
      attribute(:verify_outgoing, equal_to: [true, false])
      attribute(:verify_server_hostname, equal_to: [true, false])
      attribute(:watches, kind_of: [Hash, Mash])

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
          advertise_addr_wan
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
            content new_resource.params_to_json
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
