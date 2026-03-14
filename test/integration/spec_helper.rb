# frozen_string_literal: true

def consul_version
  input('consul_version', value: 'latest')
end
