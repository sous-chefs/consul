module ConsulCookbook
  module ResourceHelpers
    def configure_diplomat
      begin
        require 'diplomat'
      rescue LoadError => e
        raise 'The diplomat gem is required; ' \
          "include recipe[consul-criteo::diplomat] to install, details: #{e}"
      end
      Diplomat.configure do |config|
        config.url = new_resource.url
        config.acl_token = new_resource.auth_token
        config.options = { ssl: new_resource.ssl, request: { timeout: 10 } }
      end
    end

    def retry_block(opts = {}, &_block)
      opts = {
        max_tries: 3, # Number of tries
        sleep:     0, # Seconds to sleep between tries
      }.merge(opts)

      try_count = 1

      begin
        yield try_count
      rescue Diplomat::UnknownStatus
        try_count += 1

        # If we've maxed out our attempts, raise the exception to the calling code
        raise if try_count > opts[:max_tries]

        # Sleep before the next retry if the option was given
        sleep opts[:sleep]

        retry
      end
    end
  end
end
