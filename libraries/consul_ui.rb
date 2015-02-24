#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

class Chef
  module ConsulUI
    class << self
      def active_path(node)
        File.join(node['consul']['data_dir'], 'ui')
      end

      def cached_archive(node)
        File.join(Chef::Config[:file_cache_path], File.basename(remote_url(node)))
      end

      def install_path(node)
        File.join(['/opt', 'consul_ui', node['consul']['version']])
      end

      def latest_dist(node)
        File.join(install_path(node), 'dist')
      end

      def remote_filename(node)
        [node['consul']['version'], 'web_ui'].join('_')
      end

      def remote_checksum(node)
        node['consul']['checksums'].fetch(remote_filename(node))
      end

      def remote_url(node)
        node['consul']['base_url'] % { version: remote_filename(node) }
      end
    end
  end
end
