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
  install_method :binary
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
