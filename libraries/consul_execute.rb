#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise'

module ConsulCookbook
  module Resource
    # Resource for providing `consul exec` functionality.
    # @since 1.0.0
    class ConsulExecute < Chef::Resource
      include Poise(fused: true)
      provides(:consul_execute)
      default_action(:run)

      attribute(:command, kind_of: String, name_attribute: true)
      attribute(:environment, kind_of: String, default: { 'PATH' => '/usr/local/bin:/usr/bin:/bin' })
      attribute(:options, option_collector: true, default: {})

      action(:run) do
        options = new_resource.options.map do |k, v|
          next if v.is_a?(NilClass) || v.is_a?(FalseClass)
          if v.is_a?(TrueClass)
            "-#{k}"
          else
            ["-#{k}", v].join('=')
          end
        end

        command = ['/usr/bin/env consul exec',
                   options,
                   new_resource.command].flatten.compact

        notifying_block do
          execute command.join(' ') do
            environment new_resource.environment
          end
        end
      end
    end
  end
end
