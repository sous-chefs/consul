# consul_policy

Manages Consul ACL policies using the Diplomat gem.

## Actions

| Action    | Description                         |
|-----------|-------------------------------------|
| `:create` | Creates or updates policy (default) |
| `:delete` | Removes the policy                  |

## Properties

| Property      | Type   | Default                   | Description                 |
|---------------|--------|---------------------------|-----------------------------|
| `policy_name` | String | name                      | Policy name (name property) |
| `url`         | String | `'http://localhost:8500'` | Consul HTTP API URL         |
| `auth_token`  | String | required                  | Authentication token        |
| `ssl`         | Hash   | `{}`                      | SSL options                 |
| `description` | String | `''`                      | Policy description          |
| `datacenters` | Array  | `[]`                      | Datacenters scope           |
| `rules`       | String | `''`                      | Policy rules                |

## Examples

### Create a policy

```ruby
consul_policy 'read-only' do
  auth_token 'master-token'
  description 'Read-only access'
  rules 'key_prefix "" { policy = "read" }'
end
```
