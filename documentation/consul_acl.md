# consul_acl

Manages Consul ACL tokens using the Diplomat gem.

## Actions

| Action    | Description                      |
|-----------|----------------------------------|
| `:create` | Creates or updates ACL (default) |
| `:delete` | Removes the ACL                  |

## Properties

| Property     | Type   | Default                   | Description                    |
|--------------|--------|---------------------------|--------------------------------|
| `id`         | String | name                      | ACL ID (name property)         |
| `url`        | String | `'http://localhost:8500'` | Consul HTTP API URL            |
| `auth_token` | String | required                  | Authentication token           |
| `ssl`        | Hash   | `{}`                      | SSL options                    |
| `acl_name`   | String | `''`                      | ACL name                       |
| `type`       | String | `'client'`                | ACL type: client or management |
| `rules`      | String | `''`                      | ACL rules                      |

## Examples

### Create an ACL

```ruby
consul_acl '49f06aa9-782f-465a-becf-44f0aaefd335' do
  acl_name 'AwesomeApp Token'
  type 'client'
  rules 'key "" { policy = "read" }'
  auth_token 'master-token'
end
```
