#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#
module ConsulCookbook
  module Helpers::Runit
    def runit_reload_command
      %Q(#{node['runit']['sv_bin']} hup consul)
    end
  end
end
