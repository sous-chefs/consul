#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#
module ConsulCookbook
  module Helpers
    def consul_name
      new_resource.instance
    end

    def self.parsed_run_group
      return new_resource.run_group if new_resource.run_group
      node['consul']['run_group']
    end

    def self.parsed_run_user
      return new_resource.run_user if new_resource.run_user
      node['consul']['run_user']
    end

    def parsed_envfile_path
      return "/etc/default/#{consul_name}" if platform_family?('ubuntu')
      "/etc/sysconfig/#{consul_name}"
    end

    def parsed_config_dir
      return new_resource.config_dir if new_resource.config_dir
      node['consul']['config_dir']
    end

    def parsed_config_filename
      return new_resource.config_filename if new_resource.config_filename
      ::File.join(parsed_config_dir, 'default.json')
    end
  end
end
