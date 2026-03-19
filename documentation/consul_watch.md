# consul_watch

Manages Consul watch configurations as JSON files.

## Actions

| Action    | Description                 |
|-----------|-----------------------------|
| `:create` | Creates the watch (default) |
| `:delete` | Removes the watch file      |

## Properties

| Property     | Type   | Default            | Description                                                         |
|--------------|--------|--------------------|---------------------------------------------------------------------|
| `path`       | String | computed from name | Path to watch file                                                  |
| `user`       | String | `'consul'`         | File owner                                                          |
| `group`      | String | `'consul'`         | File group                                                          |
| `type`       | String |                    | Watch type: checks, event, key, keyprefix, nodes, service, services |
| `parameters` | Hash   | `{}`               | Watch parameters                                                    |

## Examples

### Event watch

```ruby
consul_watch 'app-deploy' do
  type 'event'
  parameters(handler: '/usr/local/bin/clear-disk-cache.sh')
  notifies :reload, 'consul_service[consul]', :delayed
end
```
