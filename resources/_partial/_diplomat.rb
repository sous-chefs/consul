# frozen_string_literal: true

property :url, String, default: 'http://localhost:8500'
property :auth_token, String, required: true
property :ssl, Hash, default: {}
