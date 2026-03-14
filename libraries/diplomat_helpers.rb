# frozen_string_literal: true

#
# Cookbook: consul
# License: Apache 2.0
#

module ConsulCookbook
  module DiplomatHelpers
    def configure_diplomat
      begin
        require 'diplomat'
      rescue LoadError => e
        raise 'The diplomat gem is required; ' \
          "include recipe[consul::client_gem] to install, details: #{e}"
      end
      Diplomat.configure do |config|
        config.url = new_resource.url
        config.acl_token = new_resource.auth_token
        config.options = { ssl: new_resource.ssl, request: { timeout: 10 } }
      end
    end

    def retry_block(opts = {}, &_block)
      opts = {
        max_tries: 3,
        sleep: 0,
      }.merge(opts)

      try_count = 1

      begin
        yield try_count
      rescue Diplomat::UnknownStatus
        try_count += 1
        raise if try_count > opts[:max_tries]

        sleep opts[:sleep]
        retry
      end
    end
  end
end
