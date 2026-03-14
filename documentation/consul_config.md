# consul_config

Manages the Consul agent configuration file in JSON format.

## Actions

| Action    | Description                              |
|-----------|------------------------------------------|
| `:create` | Creates the configuration file (default) |
| `:delete` | Removes the configuration file           |

## Properties

| Property          | Type           | Default                | Description                       |
|-------------------|----------------|------------------------|-----------------------------------|
| `path`            | String         | name                   | Path to config file (name property) |
| `owner`           | String         | `'consul'`             | File owner                        |
| `group`           | String         | `'consul'`             | File group                        |
| `config_dir`      | String         | `'/etc/consul/conf.d'` | Configuration directory           |
| `config_dir_mode` | String         | `'0755'`               | Config directory mode             |
| `options`         | Hash           | `{}`                   | Additional options merged into config |
| `server`          | true, false    |                        | Run as server                     |
| `bootstrap`       | true, false    |                        | Bootstrap the cluster             |
| `datacenter`      | String         |                        | Datacenter name                   |
| `encrypt`         | String         |                        | Gossip encryption key             |
| `ui`              | true, false    |                        | Enable the web UI                 |
| `bind_addr`       | String         |                        | Bind address                      |
| `client_addr`     | String         |                        | Client address                    |
| `retry_join`      | Array          |                        | Addresses to join on start        |
| `acl`             | Hash, Mash     |                        | ACL configuration block           |

See the [Consul documentation](https://developer.hashicorp.com/consul/docs/agent/config) for all available configuration options. Most options are exposed as properties.

## Examples

### Server configuration

```ruby
consul_config '/etc/consul/consul.json' do
  owner 'root'
  group 'consul'
  server true
  bootstrap true
  datacenter 'dc1'
  encrypt 'CGXC2NsXW4AvuB4h5ODYzQ=='
  ui true
end
```

### Client configuration

```ruby
consul_config '/etc/consul/consul.json' do
  retry_join %w(10.0.0.1 10.0.0.2 10.0.0.3)
end
```
