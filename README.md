consul-cookbook
===============
![Release](http://img.shields.io/github/release/johnbellone/consul-cookbook.svg)
[![Build Status](http://img.shields.io/travis/johnbellone/consul-cookbook.svg)][5]
[![Code Coverage](http://img.shields.io/coveralls/johnbellone/consul-cookbook.svg)][6]

Installs and configures [Consul][1].

## Supported Platforms

- CentOS 5.10, 6.5, 7.0
- Ubuntu 12.04, 14.04

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
    <td><tt>0.3.0</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['base_url']</tt></td>
    <td>String</td>
    <td>Base URL for binary downloads</td>
    <td><tt>https://dl.bintray.com/mitchellh/consul/</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['install_method']</tt></td>
    <td>String</td>
    <td>Method to install consul with when using default recipe: binary or source</td>
    <td><tt>binary</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['install_dir']</tt></td>
    <td>String</td>
    <td>Directory to install binary to.</td>
    <td><tt>/usr/local/bin</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['service_mode']</tt></td>
    <td>String</td>
    <td>Mode to run consul as: bootstrap, server, or client</td>
    <td><tt>bootstrap</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['data_dir']</tt></td>
    <td>String</td>
    <td>Location to store consul's data in</td>
    <td><tt>/var/lib/consul</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['config_dir']</tt></td>
    <td>String</td>
    <td>Location to read service definitions from (directoy will be created)</td>
    <td><tt>/etc/consul.d</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['servers']</tt></td>
    <td>Array Strings</td>
    <td>Consul servers to join</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['bind_addr']</tt></td>
    <td>String</td>
    <td>address that should be bound to for internal cluster communications</td>
    <td><tt>0.0.0.0</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['datacenter']</tt></td>
    <td>String</td>
    <td>Name of Datacenter</td>
    <td><tt>dc1</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['domain']</tt></td>
    <td>String</td>
    <td>Domain for service lookup dns queries</td>
    <td><tt>.consul</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['log_level']</tt></td>
    <td>String</td>
    <td>
      The level of logging to show after the Consul agent has started.
      Available: "trace", "debug", "info", "warn", "err"
    </td>
    <td><tt>info</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['node_name']</tt></td>
    <td>String</td>
    <td>The name of this node in the cluster</td>
    <td>hostname of the machine</td>
  </tr>
  <tr>
    <td><tt>['consul']['advertise_addr']</tt></td>
    <td>String</td>
    <td>address that we advertise to other nodes in the cluster</td>
    <td>Value of <i>bind_addr</i></td>
  </tr>
  <tr>
    <td><tt>['consul']['init_style']</tt></td>
    <td>String</td>
    <td>Service init mode for running consul as: init or runit</td>
    <td><tt>init</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['service_user']</tt></td>
    <td>String</td>
    <td>For runit service: run consul as this user (init uses 'root')</td>
    <td><tt>consul</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['service_group']</tt></td>
    <td>String</td>
    <td>For runit service: run consul as this group (init uses 'root')</td>
    <td><tt>consul</tt></td>
  </tr>
</table>

### Consul UI Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['consul']['client_address']</tt></td>
    <td>String</td>
    <td>Address to bind to</td>
    <td><tt>0.0.0.0</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['ui_dir']</tt></td>
    <td>String</td>
    <td>Location to download the UI to</td>
    <td><tt>/var/lib/consul/ui</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['serve_ui']</tt></td>
    <td>Boolean</td>
    <td>Determines whether the consul service also serve's the UI</td>
    <td><tt>false</tt></td>
  </tr>
</table>

## Usage

### consul::default

This uses the binary installation recipe by default. It also starts consul at boot time.

### consul::binary_install

Include `consul::binary_install` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[consul::binary_install]"
  ]
}
```

### consul::source_install

Include `consul::source_install` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[consul::source_install]"
  ]
}
```

### consul::ui

This installs the UI into a specified directory.

Include `consul::ui` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[consul::ui]"
  ]
}
```

## Authors

Created and maintained by [John Bellone][3] [@johnbellone][2] (<jbellone@bloomberg.net>) and a growing community of [contributors][4].

[1]: http://consul.io
[2]: https://twitter.com/johnbellone
[3]: https://github.com/johnbellone
[4]: https://github.com/johnbellone/consul-cookbook/graphs/contributors
[5]: http://travis-ci.org/johnbellone/consul-cookbook
[6]: https://coveralls.io/r/johnbellone/consul-cookbook
