# consul_installation

Installs HashiCorp Consul via official package repositories or binary download.

## Actions

| Action    | Description                      |
|-----------|----------------------------------|
| `:create` | Installs Consul (default)        |
| `:remove` | Removes Consul                   |

## Properties

| Property         | Type   | Default        | Description                                           |
|------------------|--------|----------------|-------------------------------------------------------|
| `version`        | String | name           | Consul version to install (name property)             |
| `install_method` | String | `'repository'` | Installation method: `repository` or `binary`         |
| `checksum`       | String |                | SHA256 checksum for binary download verification      |
| `archive_url`    | String |                | Custom URL for binary archive download                |

## Examples

### Install via package repository (recommended)

```ruby
consul_installation 'latest' do
  install_method 'repository'
end
```

### Install a specific version via repository

```ruby
consul_installation '1.22.5' do
  install_method 'repository'
end
```

### Install via binary download

```ruby
consul_installation '1.22.5' do
  install_method 'binary'
  checksum 'abc123def456...'
end
```

### Remove Consul

```ruby
consul_installation '1.22.5' do
  install_method 'repository'
  action :remove
end
```
