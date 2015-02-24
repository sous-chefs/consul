#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#
module Consul
  module Encrypt
    # TODO: (jbellone) Revisit implementation of these bits prior to
    # 1.0 release. Not sure exactly what this is used for.
    def consul_encrypted_dbi(bag, item)
      begin
        Chef::EncryptedDataBagItem.load(bag, item)
      rescue Net::HTTPServerException => e
        raise e unless e.response.code == '404'
      end
    end

    # TODO: (jbellone) Revisit implementation of these bits prior to
    # 1.0 release. Not sure exactly what this is used for.
    def consul_dbi_key_with_node_default(dbi, key)
      value = dbi[key]
      Chef::Log.warn "Consul encrypt key=#{key} doesn't exist in the databag. \
Reading it from node's attributes" if value.nil?
      value ||= node['consul'][key]
      value
    end
  end
end

class Chef::Recipe; include Consul::Encrypt; end
class Chef::Resource; include Consul::Encrypt; end
