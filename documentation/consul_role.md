# consul_role

Manages Consul ACL roles using the Diplomat gem.

## Actions

| Action    | Description                      |
|-----------|----------------------------------|
| `:create` | Creates or updates role (default) |
| `:delete` | Removes the role                 |

## Properties

| Property             | Type   | Default                   | Description                |
|----------------------|--------|---------------------------|----------------------------|
| `role_name`          | String | name                      | Role name (name property)  |
| `url`                | String | `'http://localhost:8500'` | Consul HTTP API URL        |
| `auth_token`         | String | required                  | Authentication token       |
| `ssl`                | Hash   | `{}`                      | SSL options                |
| `description`        | String | `''`                      | Role description           |
| `policies`           | Array  | `[]`                      | Associated policies        |
| `service_identities` | Array  | `[]`                      | Associated service identities |

## Examples

### Create a role

```ruby
consul_role 'api-role' do
  auth_token 'master-token'
  description 'API service role'
  policies [{ 'ID' => 'policy-id-123' }]
end
```
