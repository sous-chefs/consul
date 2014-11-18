consul-cookbook
===============
![Release](http://img.shields.io/github/release/johnbellone/consul-cookbook.svg)
[![Build Status](http://img.shields.io/travis/johnbellone/consul-cookbook.svg)][5]
[![Code Coverage](http://img.shields.io/coveralls/johnbellone/consul-cookbook.svg)][6]

Installs and configures [Consul][1].

## Supported Platforms

- CentOS 5.10, 6.5, 7.0
- RHEL 5.10, 6.5, 7.0
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
    <td><tt>0.4.1</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['base_url']</tt></td>
    <td>String</td>
    <td>Base URL for binary downloads</td>
    <td><tt>https://dl.bintray.com/mitchellh/consul/</tt></td>
  </tr>
   <tr>
    <td><tt>['consul']['encrypt']</tt></td>
    <td>String</td>
    <td>Encryption string for consul cluster.</td>
    <td><tt>nil</tt></td>
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
    <td>Mode to run consul as: bootstrap, cluster, server, or client</td>
    <td><tt>bootstrap</tt></td>
  </tr>
    <tr>
    <td><tt>['consul'][bootstrap_expect]</tt></td>
    <td>String</td>
    <td>When bootstrapping a cluster, the number of server nodes to expect.</td>
    <td><tt>nil</tt></td>
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
    <td><tt>['consul']['enable_syslog']</tt></td>
    <td>Boolean</td>
    <td>enables logging to syslog</td>
    <td><tt>nil</tt></td>
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
  <tr>
    <td><tt>['consul']['bind_interface']</tt></td>
    <td>String</td>
    <td>
      Interface to bind to, such as 'eth1'.  Sets bind_addr
      attribute to the IP of the specified interface if it exists.
    </td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['advertise_interface']</tt></td>
    <td>String</td>
    <td>
      Interface to advertise, such as 'eth1'.  Sets advertise_addr
      attribute to the IP of the specified interface if it exists.
    </td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['extra_params']</tt></td>
    <td>hash</td>
    <td>
       Pass a hash of extra params to the default.json config file
    </td>
    <td><tt>{}</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['encrypt_enabled']</tt></td>
    <td>Boolean</td>
    <td>
      To enable Consul gossip encryption
    </td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['verify_incoming']</tt></td>
    <td>Boolean</td>
    <td>
      If set to True, Consul requires that all incoming connections make use of TLS.
    </td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['verify_outgoing']</tt></td>
    <td>Boolean</td>
    <td>
      If set to True, Consul requires that all outgoing connections make use of TLS.
    </td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['key_file']</tt></td>
    <td>String</td>
    <td>
      The content of PEM encoded private key
    </td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['key_file_path']</tt></td>
    <td>String</td>
    <td>
      Path where the private key is stored on the disk
    </td>
    <td><tt>/etc/consul.d/key.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['ca_file']</tt></td>
    <td>String</td>
      The content of PEM encoded ca cert
    <td>
    </td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['ca_file_path']</tt></td>
    <td>String</td>
    <td>
      Path where ca is stored on the disk
    </td>
    <td><tt>/etc/consul.d/ca.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['cert_file']</tt></td>
    <td>String</td>
    <td>
      The content of PEM encoded cert. It should only contain the public key.
    </td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['cert_file_path']</tt></td>
    <td>String</td>
    <td>
        Path where cert is stored on the disk
    </td>
    <td><tt>/etc/consul.d/cert.pem</tt></td>
  </tr>
</table>

### Databag Attributes (optional)
Following attributes, if exist in the [encrypted databag][7], override the node attributes

<table>
  <tr>
    <th>Key</th>
    <th>Databag item</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>key_file</tt></td>
    <td>['consul']['encrypt']</td>
    <td>String</td>
    <td>The content of PEM encoded private key</td>
  </tr>
  <tr>
    <td><tt>key_file_{fqdn}</tt></td>
    <td>['consul']['encrypt']</td>
    <td>String</td>
    <td>Node's(identified by fqdn) unique PEM encoded private key. If it exists, it will override the databag and node key_file attribute</td>
  </tr>
  <tr>
    <td><tt>ca_file</tt></td>
    <td>['consul']['encrypt']</td>
    <td>String</td>
    <td>The content of PEM encoded ca cert</td>
  </tr>
  <tr>
    <td><tt>encrypt</tt></td>
    <td>['consul']['encrypt']</td>
    <td>String</td>
    <td>Consul Gossip encryption key</td>
  </tr>
  <tr>
    <td><tt>cert_file</tt></td>
    <td>['consul']['encrypt']</td>
    <td>String</td>
    <td>The content of PEM encoded cert</td>
  </tr>
  <tr>
    <td><tt>cert_file_{fqdn}</tt></td>
    <td>['consul']['encrypt']</td>
    <td>String</td>
    <td>Node's(identified by fqdn) unique PEM encoded cert. If it exists, it will override the databag and node cert_file attribute</td>
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
    <td><tt>['consul']['client_interface']</tt></td>
    <td>String</td>
    <td>
      Interface to advertise, such as 'eth1'.  Sets advertise_addr
      attribute to the IP of the specified interface if it exists.
    </td>
    <td><tt>nil</tt></td>
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

### consul::install_binary

Include `consul::install_binary` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[consul::install_binary]"
  ]
}
```

### consul::install_source

Include `consul::install_source` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[consul::install_source]"
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

### LWRP

##### Adding key watch
    consul_key_watch_def 'key-watch-name' do
      key "/key/path"
      handler "chef-client"
    end


##### Adding event watch
    consul_event_watch_def 'event-name' do
      handler "chef-client"
    end

##### Adding service without check

    consul_service_def 'voice1' do
      port 5060
      tags ['_sip._udp']
      notifies :reload, 'service[consul]'
    end

##### Adding service with check

    consul_service_def 'voice1' do
      port 5060
      tags ['_sip._udp']
      check(
        interval: '10s',
        script: 'echo ok'
      )
      notifies :reload, 'service[consul]'
    end

##### Removing service

    consul_service_def 'voice1' do
      action :delete
      notifies :reload, 'service[consul]'
    end

> Be sure to notify the Consul resource to restart when your service def changes.

####  Getting Started

To bootstrap a consul cluster follow the following steps:
 0.  Make sure that ports 8300-8302 (by default, if you configured differnt ones open those)  UDP/TCP are all open.
 1.  Bootstrap a few (preferablly 3 nodes) to be your consul servers, these will be the KV masters.
 2.  Put `node['consul']['servers'] =["Array of the bootstrapped servers ips or dns names"]` in your environment.
 3.  Apply the consul cookbook to these nodes with `node['consul']['service_mode'] = 'cluster'` (I put this in this in a CONSUL_MASTER role).
 4.  Let these machines converge, once you can run `consul members` and get a list of all of the servers your ready to move on
 5.  Apply the consul cookbook to the rest of your nodes with `node['consul']['service_mode'] = 'client'` (I put this in the environment)
 6.  Start added services and checks to your cookbooks.
 7.  If you want to get values out of consul to power your chef, curl localhost:8500/v1/kv/key/path?raw in your cookbook.

## Authors

Created and maintained by [John Bellone][3] [@johnbellone][2] (<jbellone@bloomberg.net>) and a growing community of [contributors][4].

[1]: http://consul.io
[2]: https://twitter.com/johnbellone
[3]: https://github.com/johnbellone
[4]: https://github.com/johnbellone/consul-cookbook/graphs/contributors
[5]: http://travis-ci.org/johnbellone/consul-cookbook
[6]: https://coveralls.io/r/johnbellone/consul-cookbook
[7]: https://docs.getchef.com/essentials_data_bags.html

