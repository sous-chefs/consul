class Chef
  module Consul
    class Client
      def initialize(host = '127.0.0.1', port = 8500, token = nil)
        require 'net/http'
        require 'json'
        @host = host
        @port = port
        @base_uri = "http://#{@host}:#{@port}/v1"
        @token = token || nil
      end

      def get_acl_by_name(resource)
        acls = get('acl/list')
        acls.find { |acl| acl['Name'] == resource }
      end

      def get_acl_by_id(resource)
        acls = get("acl/info/#{resource}")
        acls.find { |acl| acl['ID'] == resource }
      end

      def manage_acl(data)
        if data['ID']
          put("acl/update/#{data['ID']}", data)
        else
          put('acl/create', data)
        end
      end

      def delete_acl(resource)
        id = get_acl_by_name(resource)['ID']
        put("acl/destroy/#{id}")
      end

      private

      def http_request(method, uri, data = nil)
        method = {
          get: Net::HTTP::Get,
          put: Net::HTTP::Put
        }.fetch(method)

        http = Net::HTTP.new(uri.host, uri.port)
        request = method.new(uri.request_uri)
        request.body = data.to_json if data
        response = http.request(request)

        if response.code.to_i == 403
          fail 'Authentication Error'
        elsif response.code.to_i != 200
          fail "Failed to process request #{uri} #{response.inspect}"
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
        url = "#{@base_uri}/#{request_uri}?token=#{@token}"
        uri = URI.parse(url)
        response = http_request(:put, uri, data)
        JSON.parse("[#{response.body}]")[0]
      end
    end
  end
end
