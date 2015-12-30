#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#

module ConsulCookbook
  module Helpers
    extend self

    def arch_64?
      node['kernel']['machine'] =~ /x86_64/ ? true : false
    end

    def windows?
      node['os'].eql?('windows') ? true : false
    end

    def program_files
      'C:\\Program Files' + (arch_64? ? '' : ' x(86)')
    end

    def default_environment
      {
        'GOMAXPROCS' => [node['cpu']['total'], 2].max.to_s,
        'PATH' => '/usr/local/bin:/usr/bin:/bin'
      }
    end

    def command(config_file, config_dir)
      if windows?
        %{agent -config-file="""#{config_file}""" -config-dir="""#{config_dir}"""}
      else
        "/usr/bin/env consul agent -config-file=#{config_file} -config-dir=#{config_dir}"
      end
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
  end
end
