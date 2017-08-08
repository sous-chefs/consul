#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#

module ConsulCookbook
  module Helpers
    include Chef::Mixin::ShellOut

    extend self

    def arch_64?
      node['kernel']['machine'] =~ /x86_64/ ? true : false
    end

    def windows?
      node['os'].eql?('windows') ? true : false
    end

    # returns windows friendly version of the provided path,
    # ensures backslashes are used everywhere
    # Gently plucked from https://github.com/chef-cookbooks/windows
    def win_friendly_path(path)
      path.gsub(::File::SEPARATOR, ::File::ALT_SEPARATOR || '\\') if path
    end

    # Simply using ::File.join was causing several attributes
    # to return strange values in the resources (e.g. "C:/Program Files/\\consul\\data")
    def join_path(*path)
      windows? ? win_friendly_path(::File.join(path)) : ::File.join(path)
    end

    def program_files
      join_path('C:', 'Program Files') + (arch_64? ? '' : ' x(86)')
    end

    def config_prefix_path
      windows? ? join_path(program_files, 'consul') : join_path('/etc', 'consul')
    end

    def data_path
      windows? ? join_path(program_files, 'consul', 'data') : join_path('/var/lib', 'consul')
    end

    def command(config_file, config_dir)
      if windows?
        %(agent -config-file="#{config_file}" -config-dir="#{config_dir}")
      else
        "/usr/local/bin/consul agent -config-file=#{config_file} -config-dir=#{config_dir}"
      end
    end
  end
end

Chef::Node.send(:include, ConsulCookbook::Helpers)
