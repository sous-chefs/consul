#
# Cookbook Name:: consul
# Recipe:: ui
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
# Copyright 2014 Benny Wong <benny@bwong.net>
#
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
file Chef::ConsulUI.active_path(node) do
  action :delete
  not_if "test -L #{Chef::ConsulUI.active_path(node)}"
end

link Chef::ConsulUI.active_path(node) do
  to Chef::ConsulUI.latest_dist(node)
end
