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
    # @since 1.0.0
    class ConsulConfig < Chef::Resource
      include Poise(fused: true)
      include ConsulCookbook::Helpers
      provides(:consul_config)

      # @!attribute path
      # @return [String]
      attribute(:path, kind_of: String, name_attribute: true)

      # @!attribute owner
      # @return [String]
      attribute(:owner, kind_of: String, default: 'consul')

      # @!attribute group
      # @return [String]
      attribute(:group, kind_of: String, default: 'consul')

      # @!attribute bag_name
      # @return [String]
      attribute(:bag_name, kind_of: String, default: 'secrets')

      # @!attribute bag_item
      # @return [String]
      attribute(:bag_item, kind_of: String, default: 'consul')

      # @!attribute options
      # @return [Hash]
      attribute(:options, option_collector: true)

      # @see: http://www.consul.io/docs/agent/options.html
      attribute(:acl_datacenter, kind_of: String)
      attribute(:acl_default_policy, kind_of: String)
      attribute(:acl_down_policy, kind_of: String)
      attribute(:acl_master_token, kind_of: String)
      attribute(:acl_token, kind_of: String)
      attribute(:acl_ttl, kind_of: String)
      attribute(:addresses, kind_of: [Hash, Mash])
      attribute(:advertise_addr, kind_of: String)
      attribute(:advertise_addr_wan, kind_of: String)
      attribute(:bind_addr, kind_of: String)
      attribute(:bootstrap, equal_to: [true, false], default: false)
      attribute(:bootstrap_expect, kind_of: Integer, default: 3)
      attribute(:ca_file, kind_of: String)
      attribute(:cert_file, kind_of: String)
      attribute(:check_update_interval, kind_of: String)
      attribute(:client_addr, kind_of: String)
      attribute(:data_dir, kind_of: String)
      attribute(:datacenter, kind_of: String)
      attribute(:disable_anonymous_signature, equal_to: [true, false], default: false)
      attribute(:disable_remote_exec, equal_to: [true, false], default: false)
      attribute(:disable_update_check, equal_to: [true, false], default: false)
      attribute(:dns_config, kind_of: [Hash, Mash])
      attribute(:domain, kind_of: String)
      attribute(:enable_debug, equal_to: [true, false], default: false)
      attribute(:enable_syslog, equal_to: [true, false], default: false)
      attribute(:encrypt, kind_of: String)
      attribute(:key_file, kind_of: String)
      attribute(:leave_on_terminate, equal_to: [true, false], default: false)
      attribute(:log_level, equal_to: %w(INFO DEBUG WARN), default: 'INFO')
      attribute(:node_name, kind_of: String)
      attribute(:ports, kind_of: [Hash, Mash])
      attribute(:protocol, kind_of: String)
      attribute(:recursor, kind_of: String)
      attribute(:recursors, kind_of: Array)
      attribute(:retry_interval, kind_of: String)
      attribute(:retry_interval_wan, kind_of: String)
      attribute(:retry_join, kind_of: Array)
      attribute(:retry_join_wan, kind_of: Array)
      attribute(:rejoin_after_leave, equal_to: [true, false], default: true)
      attribute(:server, equal_to: [true, false], default: true)
      attribute(:server_name, kind_of: String)
      attribute(:skip_leave_on_interrupt, equal_to: [true, false], default: false)
      attribute(:start_join, kind_of: Array)
      attribute(:start_join_wan, kind_of: Array)
      attribute(:statsd_addr, kind_of: String)
      attribute(:statsite_addr, kind_of: String)
      attribute(:syslog_facility, kind_of: String)
      attribute(:ui, equal_to: [true, false], default: false)
      attribute(:ui_dir, kind_of: String)
      attribute(:verify_incoming, equal_to: [true, false], default: false)
      attribute(:verify_outgoing, equal_to: [true, false], default: false)
      attribute(:verify_server_hostname, equal_to: [true, false], default: false)
      attribute(:watches, kind_of: [Hash, Mash], default: {})

      # Transforms the resource into a JSON format which matches the
      # Consul service's configuration format.
      def to_json
        for_keeps = %i{acl_datacenter acl_default_policy acl_down_policy acl_master_token acl_token acl_ttl addresses advertise_addr advertise_addr_wan bind_addr bootstrap bootstrap_expect check_update_interval client_addr data_dir datacenter disable_anonymous_signature disable_remote_exec disable_update_check dns_config domain enable_debug enable_syslog encrypt leave_on_terminate log_level node_name ports protocol recursor recursors retry_interval retry_interval_wan retry_join retry_join_wan rejoin_after_leave server server_name skip_leave_on_interrupt start_join start_join_wan statsd_addr statsite_addr syslog_facility ui ui_dir verify_incoming verify_outgoing verify_server_hostname watches}
        for_keeps << %i{ca_file cert_file key_file} if tls?
        for_keeps = for_keeps.flatten

        config = to_hash.keep_if do |k, _|
          for_keeps.include?(k.to_sym)
        end.merge(options)
        JSON.pretty_generate(Hash[config.sort], quirks_mode: true)
      end

      def tls?
        verify_incoming || verify_outgoing
      end

      action(:create) do
        notifying_block do
          if new_resource.tls?
            include_recipe 'chef-vault::default'

            [new_resource.ca_file, new_resource.cert_file, new_resource.key_file].each do |filename|
              directory ::File.dirname(filename) do
                recursive true
                if node['os'].eql? 'linux'
                  owner new_resource.owner
                  group new_resource.group
                  mode '0755'
                end
              end
            end

            item = chef_vault_item(new_resource.bag_name, new_resource.bag_item)
            file new_resource.ca_file do
              content item['ca_certificate']
              if node['os'].eql? 'linux'
                owner new_resource.owner
                group new_resource.group
                mode '0644'
              end
            end

            file new_resource.cert_file do
              content item['certificate']
              if node['os'].eql? 'linux'
                owner new_resource.owner
                group new_resource.group
                mode '0644'
              end
            end

            file new_resource.key_file do
              sensitive true
              content item['private_key']
              if node['os'].eql? 'linux'
                owner new_resource.owner
                group new_resource.group
                mode '0640'
              end
            end
          end

          directory ::File.dirname(new_resource.path) do
            recursive true
            if node['os'].eql? 'linux'
              owner new_resource.owner
              group new_resource.group
              mode '0755'
            end
            not_if { ::File.dirname(new_resource.path) == '/etc' }
          end

          file new_resource.path do
            if node['os'].eql? 'linux'
              owner new_resource.owner
              group new_resource.group
              mode '0640'
            end
            content new_resource.to_json
          end
        end
      end

      action(:delete) do
        notifying_block do
          if new_resource.tls?
            file new_resource.cert_file do
              action :delete
            end

            file new_resource.key_file do
              action :delete
            end
          end

          file new_resource.path do
            action :delete
          end
        end
      end
    end
  end
end
