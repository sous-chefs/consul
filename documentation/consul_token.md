# consul_token

Manages Consul ACL tokens using the Diplomat gem.

## Actions

| Action    | Description                       |
|-----------|-----------------------------------|
| `:create` | Creates or updates token (default) |
| `:delete` | Removes the token                 |

## Properties

| Property             | Type        | Default                   | Description                |
|----------------------|-------------|---------------------------|----------------------------|
| `description`        | String      | name                      | Token description (name property) |
| `url`                | String      | `'http://localhost:8500'` | Consul HTTP API URL        |
| `auth_token`         | String      | required                  | Authentication token       |
| `ssl`                | Hash        | `{}`                      | SSL options                |
| `secret_id`          | String      |                           | Token secret ID            |
| `policies`           | Array       | `[]`                      | Associated policies        |
| `roles`              | Array       | `[]`                      | Associated roles           |
| `service_identities` | Array       | `[]`                      | Associated service identities |
| `expiration_time`    | String      | `''`                      | Token expiration time      |
| `expiration_ttl`     | String      |                           | Token expiration TTL       |
| `local`              | true, false | `false`                   | Local token only           |

## Examples

### Create a token

```ruby
consul_token 'app-token' do
  auth_token 'master-token'
  policies %w(read-only)
end
```
