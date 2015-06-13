# Copyright 2014 Benny Wong <benny@bwong.net>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node['platform'] == 'windows'
  Chef::Log.error "UI Installation not supported for Windows"
else
  include_recipe 'libarchive::default'

  archive = remote_file Chef::ConsulUI.cached_archive(node) do
    source Chef::ConsulUI.remote_url(node)
    checksum Chef::ConsulUI.remote_checksum(node)
  end

  libarchive_file 'consul_ui.zip' do
    path archive.path
    extract_to Chef::ConsulUI.install_path(node)
    extract_options :no_overwrite

    action :extract
  end

  # JW TODO: Remove after next major release.
  directory Chef::ConsulUI.active_path(node) do
    action :delete
    recursive true
    not_if "test -L #{Chef::ConsulUI.active_path(node)}"
  end

  link Chef::ConsulUI.active_path(node) do
    to Chef::ConsulUI.latest_dist(node)
  end
end
