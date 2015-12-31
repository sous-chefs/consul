#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
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

    def prefix_path
      windows? ? join_path(program_files, 'consul') : join_path('/etc', 'consul')
    end

    def command(config_file, config_dir)
      if windows?
        %{agent -config-file="""#{config_file}""" -config-dir="""#{config_dir}"""}
      else
        "/usr/bin/env consul agent -config-file=#{config_file} -config-dir=#{config_dir}"
      end
    end

    # 1 is command not found
    def correct_version?(executable, version)
      shell_out!(%{"#{executable}" version}, returns: [0, 1]).stdout.match version
    end

    def binary_checksum(item)
      node['consul']['checksums'].fetch(binary_filename item)
    end

    def binary_filename(item)
      case item
      when 'binary'
        arch = arch_64? ? 'amd64' : '386'
        ['consul', version, node['os'], arch].join('_')
      when 'web_ui'
        ['consul', version, 'web_ui'].join('_')
      end
    end

    def nssm_exe
      "#{node['nssm']['install_location']}\\nssm.exe"
    end

    def default_environment
      {
        'GOMAXPROCS' => [node['cpu']['total'], 2].max.to_s,
        'PATH' => '/usr/local/bin:/usr/bin:/bin'
      }
    end
  end
end
