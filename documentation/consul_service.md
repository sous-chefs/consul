# consul_service

Manages the Consul systemd service unit.

## Actions

| Action     | Description                                  |
|------------|----------------------------------------------|
| `:enable`  | Creates systemd unit and enables it (default) |
| `:start`   | Starts the service                           |
| `:stop`    | Stops the service                            |
| `:restart` | Restarts the service                         |
| `:reload`  | Reloads the service configuration            |
| `:disable` | Stops and removes the systemd unit           |

## Properties

| Property            | Type        | Default                      | Description                    |
|---------------------|-------------|------------------------------|--------------------------------|
| `config_file`       | String      | `'/etc/consul/consul.json'`  | Path to config file            |
| `user`              | String      | `'consul'`                   | Service user                   |
| `group`             | String      | `'consul'`                   | Service group                  |
| `environment`       | Hash        | computed                     | Environment variables          |
| `data_dir`          | String      | `'/var/lib/consul'`          | Data directory                 |
| `config_dir`        | String      | `'/etc/consul/conf.d'`       | Configuration directory        |
| `systemd_params`    | Hash        | `{}`                         | Extra systemd unit parameters  |
| `program`           | String      | `'/usr/local/bin/consul'`    | Path to consul binary          |
| `restart_on_update` | true, false | `true`                       | Restart on unit file changes   |

## Examples

### Basic service

```ruby
consul_service 'consul' do
  config_file '/etc/consul/consul.json'
  user 'consul'
  group 'consul'
end
```

### With custom systemd parameters

```ruby
consul_service 'consul' do
  config_file '/etc/consul/consul.json'
  systemd_params('LimitNOFILE' => 65535)
end
```
