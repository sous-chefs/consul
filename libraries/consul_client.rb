class Chef
  module Consul
    class Client
      def initialize(host ,port, token)
        require 'net/http'
        require 'json'
        @host = host || '127.0.0.1'
        @port = port || '8500'
        @base_uri = "http://#{@host}:#{@port}/v1"
        @token = token || nil
      end

      def http_request(method, uri, data = nil)
        method = {
          get: Net::HTTP::Get,
          put: Net::HTTP::Put,
        }.fetch(method)

        http = Net::HTTP.new(uri.host, uri.port)
        request = method.new(uri.request_uri)
        request.body = data.to_json if data
        response = http.request(request)

        if response.code.to_i == 403
          raise "Authentication Error"
        elsif response.code.to_i != 200
          raise "Failed to process request #{uri} #{response.inspect}"
        end
        response
      end

      def get(request_uri)
        url = "#{@base_uri}/#{request_uri}?token=#{@token}"
        uri = URI.parse(url)
        response = http_request(:get, uri)
        JSON.parse("[#{response.body}]")[0]
      end

      def put(request_uri, data = nil)
        #url = @base_uri + request_uri + '?token=' + @token
        url = "#{@base_uri}/#{request_uri}?token=#{@token}"
        uri = URI.parse(url)
        response = http_request(:put, uri, data)
        JSON.parse("[#{response.body}]")[0]
      end

      def get_acl_by_name(resource)
        acls = get('acl/list')
        acls.select { |acl| acl['Name'] == resource }[0]
      end

      def get_acl_by_ID(resource)
        acls = get("acl/info/#{resource}")
        acls.select { |acl| acl['ID'] == resource }[0]
      end

      def create_acl(data)
        put("acl/create", data)
      end

      def delete_acl(resource)
        id = get_acl_by_name(resource)['ID']
        put("acl/destroy/#{id}")
      end
    end
  end
end
