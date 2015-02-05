#
# Copyright 2014-2015 John Bellone <jbellone@bloomberg.net>
# Copyright 2014-2015 Bloomberg Finance L.P.
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class Chef
  module Consul
    class << self
      def active_binary(node)
        File.join(node['consul']['install_dir'], 'consul')
      end

      def cached_archive(node)
        File.join(Chef::Config[:file_cache_path], File.basename(remote_url(node)))
      end

      def latest_binary(node)
        File.join(install_path(node), 'consul')
      end

      def remote_checksum(node)
        node['consul']['checksums'].fetch(remote_filename(node))
      end

      def remote_filename(node)
        [node['consul']['version'], node['os'], arch(node)].join('_')
      end

      def remote_url(node)
        node['consul']['base_url'] % { version: remote_filename(node) }
      end

      def source_binary(node)
        File.join(node['go']['gobin'], 'consul')
      end

      def install_path(node)
        File.join(['/opt', 'consul', node['consul']['version']])
      end

      private

        def arch(node)
          node['kernel']['machine'] =~ /x86_64/ ? 'amd64' : '386'
        end
    end
  end
end
