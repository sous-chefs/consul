consul-cookbook
===============
[![Join the chat at https://gitter.im/johnbellone/consul-cookbook](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/johnbellone/consul-cookbook?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
![Release](http://img.shields.io/github/release/johnbellone/consul-cookbook.svg)
[![Build Status](http://img.shields.io/travis/johnbellone/consul-cookbook.svg)](http://travis-ci.org/johnbellone/consul-cookbook)
[![Code Coverage](http://img.shields.io/coveralls/johnbellone/consul-cookbook.svg)](https://coveralls.io/r/johnbellone/consul-cookbook)

[Application cookbook][0] which installs and configures [Consul][1].

This is a hybrid cookbook which provides resources/providers to
install and configure the [Consul agent][1]. A default recipe exists
to show off the most common usage - writing out a Consul configuration
and creating the Consul service - from node attributes. It is important
to note that this cookbook is essentially a [Library cookbook][3] which
provides an default example recipe (e.g. application cookbook).

## Platforms
- CentOS >= 6.4 (RHEL)
- Ubuntu >= 12.04
- Windows

## Dependencies
This cookbook has a few dependencies which are pulled in and required
when uploaded to a Chef Server. Not all recipes (or resources, for
that matter) will run unless certain functionality is configured. For
example, the Golang cookbook default recipe is only included when
install method is from source.

| Cookbook Name | Description |
| ------------- | ----------- |
| Chef Vault | Provides HWRP for managing secrets for TLS certificates/keys. |
| Golang | Provides recipes for installing Go language for source compliation. |
| libartifact | Provids HWRP for managing versions of artifacts on disk. |
| Poise | Provides helpers for writing reusable HWRP code. |
| Poise Service | Provides helpers for abstracting service lifecycle management. |
| SELinux | Provides recipes for configuring SELinux subsystem. |

## Attributes
This cookbook provides node attributes which can be used to fine tune
how the recipes install and configure the Consul client, server and
UI. These values are passed into the resource/providers for
validation prior to converging.

All of the attribute keys are nested immediately under
`node['consul']` and thus are accessible like
`node.default['consul']['version'] = '0.5.1'`.

|   Key   |  Type  |   Description  |  Default  |
|---------|--------|----------------|-----------|
| version | String | Installation version | 0.5.2 |
| remote_url | String | Remote URL for download. | https://dl.bintray.com/mitchellh/consul |
| service_name | String | Name of the service (operating system) | consul |
| service_user | String | Name of the service user | consul |
| service_group | String | Name of the service group | consul |

## Resources/Providers
This cookbook provides resource and provider primitives to manage the
Consul client, server and UI. These primitives are what is used in the
recipes, and should be used in your own [wrapper cookbooks][2].

### consul_config
| Parameter | Type | Description | Default |
| --------- | ---- | ----------- | ------- |
| path | String | File system path to write configuration. | name |
| user | String | System username for configuration ownership. | consul |
| group | String | System groupname for configuration ownership. | consul |
| bag_name | String | Name of the chef-vault data bag for TLS configuration. | secrets |
| bag_item | String | Item of the chef-vault data bag for TLS configuration. | consul |

```ruby
consul_config '/etc/consul.json' do
  user 'jbellone'
  group 'staff'
end
```
### consul_service
| Parameter | Type | Description | Default |
| --------- | ---- | ----------- | ------- |
| user | String | System username for configuration ownership. | consul |
| group | String | System groupname for configuration ownership. | consul |
| install_method | String | Determines method of installing Consul agent on node. | source, binary, package |
| install_path | String | Absolute path to where Consul agent is unpacked. | /srv |
| version | String | The version of Consul agent to install. | nil |
| config_file | String | Absolute path to the Consul agent's configuration file. | /etc/consul.json |
| config_dir | String | Absolute path to configuration directory (for definitions, watches). | /etc/consul |
| data_dir | String | Absolute path to the Consul agent's data directory. | /var/lib/consul |

```ruby
consul_service 'consul' do
  user 'consul'
  group 'consul'
  install_method 'binary'
  binary_url node['consul']['binary_url']
end
```
### consul_watch
| Parameter | Type | Description | Default |
| --------- | ---- | ----------- | ------- |
| path | String | File system path to write configuration. | name |
| user | String | System username for configuration ownership. | consul |
| group | String | System groupname for configuration ownership. | consul |
| type | String | Type of the Consul watch to configure. | key, keyprefix, service, event |
| parameters | Hash | Parameters to configure; depends on type of watch. | {} |

```ruby
consul_watch '/etc/consul/foobarbaz.json' do
  type 'key'
  parameters(key: 'foo/bar/baz', handler: '/bin/false')
end
```
```ruby
consul_watch '/etc/consul/foobarbaz.json' do
  type 'keyprefix'
  parameters(prefix: 'foo/', handler: '/bin/false')
end
```
```ruby
consul_watch '/etc/consul/foobarbaz.json' do
  type 'service'
  parameters(service: 'redis', handler: '/bin/false')
end
```
```ruby
consul_watch '/etc/consul/foobarbaz.json' do
  type 'event'
  parameters(event: 'web-deploy', handler: '/bin/false')
end
```
### consul_definition
| Parameter | Type | Description | Default |
| --------- | ---- | ----------- | ------- |
| path | String | File system path to write configuration. | name |
| user | String | System username for configuration ownership. | consul |
| group | String | System groupname for configuration ownership. | consul |
| type | String | Type of definition | service, check |
```ruby
consul_definition '/etc/consul/redis.json' do
  type 'service'
  parameters(tags: %w{master}, address: '127.0.0.1', port: 6379)
end
```

[0]: http://blog.vialstudios.com/the-environment-cookbook-pattern/#theapplicationcookbook
[1]: http://consul.io
[2]: http://blog.vialstudios.com/the-environment-cookbook-pattern#thewrappercookbook
[3]: http://blog.vialstudios.com/the-environment-cookbook-pattern/#thelibrarycookbook
