class Chef
  class Recipe
    # Don't throw the error if it doesn't exist
    def consul_encrypted_dbi
      begin
        # loads the secret from /etc/chef/encrypted_data_bag_secret
        Chef::EncryptedDataBagItem.load(node['consul']['data_bag'], node['consul']['data_bag_encrypt_item'])
      rescue Net::HTTPServerException => e
        raise e unless e.response.code == '404'
      end
    end

    def consul_dbi_key_with_node_default(dbi, key)
      value = dbi[key]
      Chef::Log.warn "Consul encrypt key=#{key} doesn't exist in the databag. \
Reading it from node's attributes" if value.nil?
      value ||= node['consul'][key]
      value
    end
  end
end
