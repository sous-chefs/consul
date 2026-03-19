# consul_definition

Manages Consul service and check definitions as JSON configuration files.

## Actions

| Action    | Description                      |
|-----------|----------------------------------|
| `:create` | Creates the definition (default) |
| `:delete` | Removes the definition file      |

## Properties

| Property     | Type   | Default            | Description                                       |
|--------------|--------|--------------------|---------------------------------------------------|
| `path`       | String | computed from name | Path to definition file                           |
| `user`       | String | `'consul'`         | File owner                                        |
| `group`      | String | `'consul'`         | File group                                        |
| `mode`       | String | `'0640'`           | File mode                                         |
| `type`       | String |                    | Definition type: check, service, checks, services |
| `parameters` | Hash   | `{}`               | Definition parameters                             |

## Examples

### Service definition

```ruby
consul_definition 'redis' do
  type 'service'
  parameters(tags: %w(master), address: '127.0.0.1', port: 6379)
  notifies :reload, 'consul_service[consul]', :delayed
end
```

### Check definition

```ruby
consul_definition 'mem-util' do
  type 'check'
  parameters(script: '/usr/local/bin/check_mem.py', interval: '10s')
  notifies :reload, 'consul_service[consul]', :delayed
end
```
