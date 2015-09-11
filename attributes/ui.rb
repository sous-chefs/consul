#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

default['consul']['ui']['enabled'] = true
default['consul']['ui']['version'] = '0.5.2'
default['consul']['ui']['url'] = 'https://dl.bintray.com/mitchellh/consul/%{version}_web_ui.zip'

