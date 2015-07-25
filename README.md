consul-cookbook
===============

[![Join the chat at https://gitter.im/johnbellone/consul-cookbook](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/johnbellone/consul-cookbook?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
![Release](http://img.shields.io/github/release/johnbellone/consul-cookbook.svg)
[![Build Status](http://img.shields.io/travis/johnbellone/consul-cookbook.svg)][5]
[![Code Coverage](http://img.shields.io/coveralls/johnbellone/consul-cookbook.svg)][6]

Installs and configures [Consul][1] client, server and UI.

## Supported Platforms
- CentOS 6.5, 7.0
- RHEL 6.5, 7.0
- Ubuntu 12.04, 14.04
- Arch Linux
- Windows

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
    <td><tt>0.5.0</tt></td>
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
    <td>Method to install consul with when using default recipe: 'binary', 'source' or 'windows'</td>
    <td>
      \*nix: <tt> binary</tt></br>
      Windows: <tt>binary</tt>
    </td>
  </tr>
  <tr>
    <td><tt>['consul']['choco_source']</tt></td>
    <td>String</td>
    <td>Source to use for fetching the chocolatey package. Defaults to the chocolatey public feed</td>
    <td><tt>https://chocolatey.org/api/v2/</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['install_dir']</tt></td>
    <td>String</td>
    <td>Directory to install binary to.</td>
    <td>
      \*nix: <tt>/usr/local/bin</tt></br>
      Windows: <tt>{chocolatey_install_dir}\lib\consul.{consul_version}</tt>
    </td>
  </tr>
  <tr>
    <td><tt>['consul']['service_mode']</tt></td>
    <td>String</td>
    <td>Mode to run consul as: bootstrap, cluster, server, or client</td>
    <td><tt>bootstrap</tt></td>
  </tr>
    <tr>
    <td><tt>['consul']['bootstrap_expect']</tt></td>
    <td>String</td>
    <td>When bootstrapping a cluster, the number of server nodes to expect.</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['data_dir']</tt></td>
    <td>String</td>
    <td>Location to store consul's data in</td>
    <td>
      \*nix: <tt>/var/lib/consul</tt></br>
      Windows: <tt>C:\ProgramData\consul\data</tt>
    </td>
  </tr>
  <tr>
    <td><tt>['consul']['config_dir']</tt></td>
    <td>String</td>
    <td>Location to read service definitions from (directoy will be created)</td>
    <td>
      \*nix: <tt>/etc/consul.d</tt></br>
      Windows: <tt>C:\ProgramData\consul\config</tt>
    </td>
  </tr>
  <tr>
    <td><tt>['consul']['etc_config_dir']</tt></td>
    <td>String</td>
    <td>Misc. configuration directory that might need to be execute during service start</td>
    <td>
      Debian: <tt>/etc/default/consul</tt></br>
      Windows: <tt>{chocolatey_install_dir}\lib\consul.{consul_version}\tools</tt></br>
      Other: <tt>/etc/sysconfig/consul</tt>
    </td>
  </tr>
  <tr>
    <td><tt>['consul']['servers']</tt></td>
    <td>Array Strings</td>
    <td>Consul servers to join</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['retry_on_join']</tt></td>
    <td>Boolean</td>
    <td>Set to true to wait for servers to be up before try to elect a leader</td>
    <td><tt>false</tt></td>
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
    <td><tt>consul</tt></td>
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
      The level of logging to show after the Consul agent has started: 'trace', 'debug', 'info', 'warn', or 'err'
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
    <td>Service init mode for running consul as: 'init', 'runit', 'systemd', or 'windows'</td>
    <td>
      \*nix: <tt>init</tt></br>
      Windows: <tt>windows</tt>
    </td>
  </tr>
  <tr>
    <td><tt>['consul']['service_user']</tt></td>
    <td>String</td>
    <td>For runit/systemd service: run consul as this user (init uses 'root')</td>
    <td><tt>consul</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['service_group']</tt></td>
    <td>String</td>
    <td>For runit/systemd service: run consul as this group (init uses 'root')</td>
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
    <td>
      The content of PEM encoded ca cert
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
  <tr>
    <td><tt>['consul']['statsd_addr']</tt></td>
    <td>String</td>
    <td>This provides the address of a statsd instance (UDP).</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['atlas_autojoin']</tt></td>
    <td>Boolean</td>
    <td>
        Determines whether Consul attempts to auto-join the cluster provided by <tt>atlas_cluster</tt> using the value of <tt>atlas_token</tt>
    </td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['atlas_cluster']</tt></td>
    <td>String</td>
    <td>
        Name of Atlas cluster to auto-join
    </td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['atlas_token']</tt></td>
    <td>String</td>
    <td>
        API token used for Atlas integration
    </td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['consul']['startup_sleep']</tt></td>
    <td>Integer</td>
    <td>
        Delay to return-of-control when invoked via an init.d script. Protects consul from an early HUP.
    </td>
    <td><tt>3</tt></td>
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
    <td><tt>['consul']['client_addr']</tt></td>
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
    <td><tt>['consul']['serve_ui']</tt></td>
    <td>Boolean</td>
    <td>Determines whether the consul service also serve's the UI</td>
    <td><tt>false</tt></td>
  </tr>
</table>

## Usage
The easiest way to bootstrap a cluster is to use the cluster recipe
and use [Chef provisioning][8] which is a relatively new
extension. This extension allows you to use any driver and easily
stand up a cluster. Once the [Chef Development Kit][9] has been
installed you can run the following command to provision a cluster.

```ruby
gem install chef-provisioning chef-provisioning-fog
export CHEF_DRIVER=fog:AWS
chef-client -z cluster.rb
```

Please follow the [Chef provisioning README][10] which provides more
detailed information about provisioning. You'll need to configure
your credentials prior to provisioning.

### consul::default
The default recipe will install the Consul agent using the
`consul::install_binary` recipe. It will also configure and
start consul at the machine boot.

### consul::install_binary
If you only wish to simply install the binary from the official
mirror you simply include `consul::install_binary` in your node's
`run_list`:

```json
{
  "run_list": [
    "recipe[consul::install_binary]"
  ]
}
```

### consul::install_source
Instead if you wish to install Consul from source you simply need
to include `consul::install_source` in your node's `run_list`. This
will also configure the Go language framework on the node to build
the application.

```json
{
  "run_list": [
    "recipe[consul::install_source]"
  ]
}
```

### consul::ui
Installing the separate Consul UI simply requires you to include
the `consul::ui` recipe in your node's `run_list`. Consul UI is not supported
on Windows platform.

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

##### Adding services watch
    consul_services_watch_def 'services-name' do
      handler "chef-client"
    end

##### Adding service watch
    consul_service_watch_def 'service-name' do
		  passingonly true
      handler "chef-client"
    end

##### Adding service without check

    consul_service_def 'voice1' do
      port 5060
      tags ['_sip._udp']
      notifies :reload, 'service[consul]'
    end

##### Adding services with checks

    consul_service_def 'voice1' do
      port 5060
      tags ['_sip._udp']
      check(
        interval: '10s',
        script: 'echo ok'
      )
      notifies :reload, 'service[consul]'
    end

    consul_service_def 'server1' do
      port 80
      tags ['http']
      check(
        interval: '10s',
        http: 'http://localhost:80'
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
 0.  Make sure that ports 8300-8302 (by default, if you configured different ones open those)  UDP/TCP are all open.
 1.  Bootstrap a few (preferablly 3 nodes) to be your consul servers, these will be the KV masters.
 2.  Put `node['consul']['servers'] =["Array of the bootstrapped servers ips or dns names"]` in your environment.
 3.  Apply the consul cookbook to these nodes with `node['consul']['service_mode'] = 'cluster'` (I put this in this in a CONSUL_MASTER role).
 4.  Let these machines converge, once you can run `consul members` and get a list of all of the servers your ready to move on
 5.  Apply the consul cookbook to the rest of your nodes with `node['consul']['service_mode'] = 'client'` (I put this in the environment)
 6.  Start adding services and checks to your cookbooks.
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
[8]: https://github.com/opscode/chef-provisioning
[9]: https://github.com/opscode/chef-dk
[10]: https://github.com/opscode/chef-provisioning/blob/master/README.md
