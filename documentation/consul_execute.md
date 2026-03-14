# consul_execute

Runs a command via `consul exec` on remote nodes.

## Actions

| Action | Description              |
|--------|--------------------------|
| `:run` | Runs the command (default) |

## Properties

| Property      | Type   | Default                                    | Description          |
|---------------|--------|--------------------------------------------|----------------------|
| `command`     | String | name                                       | Command to execute (name property) |
| `environment` | Hash   | `{ 'PATH' => '/usr/local/bin:/usr/bin:/bin' }` | Environment variables |
| `options`     | Hash   | `{}`                                       | Consul exec options  |

## Examples

### Basic execution

```ruby
consul_execute 'uptime'
```

### With options

```ruby
consul_execute 'uptime' do
  options(service: 'api')
end
```
