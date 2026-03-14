# Consul Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/consul.svg)](https://supermarket.chef.io/cookbooks/consul)
[![CI State](https://github.com/sous-chefs/consul/workflows/ci/badge.svg)](https://github.com/sous-chefs/consul/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Resource cookbook which installs and configures [HashiCorp Consul](https://consul.io).

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you'd like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

- Chef Infra Client >= 15.3
- Linux only (systemd-based distributions)

### Supported Platforms

- AlmaLinux 8, 9
- Amazon Linux 2023
- CentOS Stream 9
- Debian 12, 13
- Fedora (latest)
- openSUSE Leap 15
- Oracle Linux 8, 9
- Red Hat Enterprise Linux 8, 9
- Rocky Linux 8, 9
- Ubuntu 20.04, 22.04, 24.04

## Resources

This cookbook provides custom resources only — no recipes or node attributes. Use these resources directly in your wrapper cookbook recipes.

- [consul_installation](documentation/consul_installation.md)
- [consul_config](documentation/consul_config.md)
- [consul_service](documentation/consul_service.md)
- [consul_definition](documentation/consul_definition.md)
- [consul_watch](documentation/consul_watch.md)
- [consul_execute](documentation/consul_execute.md)
- [consul_acl](documentation/consul_acl.md)
- [consul_policy](documentation/consul_policy.md)
- [consul_role](documentation/consul_role.md)
- [consul_token](documentation/consul_token.md)

## Quick Start

### Server

```ruby
consul_installation 'latest' do
  install_method 'repository'
end

group 'consul' do
  system true
end

user 'consul' do
  system true
  group 'consul'
  shell '/bin/false'
end

config = consul_config '/etc/consul/consul.json' do
  owner 'root'
  group 'consul'
  server true
  bootstrap true
  datacenter 'dc1'
  ui true
  notifies :reload, 'consul_service[consul]', :delayed
end

consul_service 'consul' do
  config_file config.path
  user 'consul'
  group 'consul'
end
```

### Client

```ruby
consul_installation 'latest' do
  install_method 'repository'
end

group 'consul' do
  system true
end

user 'consul' do
  system true
  group 'consul'
  shell '/bin/false'
end

config = consul_config '/etc/consul/consul.json' do
  retry_join %w(10.0.0.1 10.0.0.2 10.0.0.3)
  notifies :reload, 'consul_service[consul]', :delayed
end

consul_service 'consul' do
  config_file config.path
  user 'consul'
  group 'consul'
end
```

### Installation Methods

The `consul_installation` resource supports two methods:

- **`repository`** (default) — Installs via official HashiCorp APT/YUM repositories. Recommended for most platforms.
- **`binary`** — Downloads a zip archive from releases.hashicorp.com. Required for openSUSE (no official repo).

```ruby
consul_installation '1.22.5' do
  install_method 'binary'
  checksum 'abc123...'
end
```

### Watches and Definitions

```ruby
consul_definition 'redis' do
  type 'service'
  parameters(tags: %w(master), address: '127.0.0.1', port: 6379)
  notifies :reload, 'consul_service[consul]', :delayed
end

consul_watch 'app-deploy' do
  type 'event'
  parameters(handler: '/usr/local/bin/clear-disk-cache.sh')
  notifies :reload, 'consul_service[consul]', :delayed
end
```

### ACLs

The `consul_acl`, `consul_policy`, `consul_role`, and `consul_token` resources require the [Diplomat](https://github.com/WeAreFarmGeek/diplomat) Ruby gem.

```ruby
consul_acl '49f06aa9-782f-465a-becf-44f0aaefd335' do
  acl_name 'AwesomeApp Token'
  type 'client'
  rules 'key "" { policy = "read" }'
  auth_token 'master-token'
end
```

## Upgrading from 5.x

Version 6.0 is a **breaking change**:

- **Recipes and attributes removed** — use custom resources directly in your wrapper cookbook
- **Windows support removed** — Linux only (systemd)
- **Consul < 1.0 support removed** — `config_v0` resource deleted
- **NSSM dependency removed**
- **Installation via repository** is now the default (previously binary download)
- **Platform support updated** — EOL platforms removed (CentOS 7/8, Ubuntu 16.04/18.04, Debian 9/10)

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
