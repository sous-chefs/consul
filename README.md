consul-cookbook
===============
[![Join the chat at https://gitter.im/johnbellone/consul-cookbook](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/johnbellone/consul-cookbook?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
![Release](http://img.shields.io/github/release/johnbellone/consul-cookbook.svg)
[![Build Status](http://img.shields.io/travis/johnbellone/consul-cookbook.svg)](http://travis-ci.org/johnbellone/consul-cookbook)
[![Code Coverage](http://img.shields.io/coveralls/johnbellone/consul-cookbook.svg)](https://coveralls.io/r/johnbellone/consul-cookbook)

[Application cookbook][0] which installs and configures [Consul][1].

## Attributes
This cookbook provides node attributes which can be used to fine tune
how the recipes install and configure the Consul client, server and
UI. These values are passed into the resource/providers for
validation prior to converging.

|   Key   |  Type  |   Description  |  Default  |
|---------|--------|----------------|-----------|
| ['consul']['version'] | String | Installation version | 0.5.1 |
| ['consul']['remote_url'] | String | Remote URL for download. | https://dl.bintray.com/mitchellh/consul |
| ['consul']['service_name'] | String | Name of the service (operating system) | consul |
| ['consul']['service_user'] | String | Name of the service user | consul |
| ['consul']['service_group'] | String | Name of the service group | consul |

## Resources/Providers
This cookbook provides resource and provider primitives to manage the
Consul client, server and UI. These primitives are what is used in the
recipes, and should be used in your own [wrapper cookbooks][2].

### consul_client
### consul_config
### consul_service
### consul_watch
### consul_definition

[0]: http://blog.vialstudios.com/the-environment-cookbook-pattern/#theapplicationcookbook
[1]: http://consul.io
[2]: http://blog.vialstudios.com/the-environment-cookbook-pattern#thewrappercookbook
