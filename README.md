# consul-cookbook

Installs and configures [Consul][1].

## Supported Platforms

CentOS 5.10, 6.5
Ubuntu 12.04, 14.04

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['consul']['version']</tt></td>
    <td>String</td>
    <td>Version to install</td>
    <td><tt>0.1.0</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['base_url']</tt></td>
    <td>String</td>
    <td>Base URL for binary downloads</td>
    <td><tt>https://dl.bintray.com/mitchellh/consul/</tt></td>
  </tr>
</table>

## Usage

### consul::default

Include `consul` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[consul]"
  ]
}
```

### consul::binary_install

Include `consul::binary_install` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[consul::binary_install]"
  ]
}
```

## License and Authors

Author:: John Bellone [@johnbellone][2] (<jbellone@bloomberg.net>)

[1]: http://consul.io
[2]: https://twitter.com/johnbellone
