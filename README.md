consul-cookbook
===============
[![Join the chat at https://gitter.im/johnbellone/consul-cookbook](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/johnbellone/consul-cookbook?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
![Release](http://img.shields.io/github/release/johnbellone/consul-cookbook.svg)
[![Build Status](http://img.shields.io/travis/johnbellone/consul-cookbook.svg)](http://travis-ci.org/johnbellone/consul-cookbook)
[![Code Coverage](http://img.shields.io/coveralls/johnbellone/consul-cookbook.svg)](https://coveralls.io/r/johnbellone/consul-cookbook)

[Application cookbook][0] which installs and configures [Consul][1].

Consul is a tool for discovering and configuring services within your
infrastructure. This is an application cookbook which takes a
simplified approach to configuring and installing
Consul. Additionally, it provides Chef primitives for more advanced
configuration.

## Basic Usage
For most infrastructure we suggest first starting with the default
recipe. This installs and configures Consul from the latest supported
release. It is also what is used to certify platform support through
the use of our integration tests.

This cookbook provides node attributes which are used to fine tune
the default recipe which installs and configures Consul. These values
are passed directly into the Chef resource/providers which are exposed
for more advanced configuration.

Out of the box the following platforms are certified to work and are
tested using our [Test Kitchen][8] configuration. Additional platforms
_may_ work, but your mileage may vary.
- CentOS (RHEL) 6.6, 7.1
- Ubuntu 12.04, 14.04
- Windows

### Client
Out of the box the default recipe installs and configures the Consul
agent to run as a service in _client mode_. The intent here is that
your infrastructure already has a [quorum of servers][13]. In order
to configure Consul to connect to your cluster you would supply an
array of addresses for the Consul agent to join. This would be done
in your [wrapper cookbook][2]:
```ruby
node.default['consul']['config']['start_join'] = %w{c1.internal.corporate.com c2.internal.corporate.com c3.internal.corporate.com}
```

### Server
This cookbook is designed to allow for the flexibility to bootstrap a
new cluster. The best way to do this is through the use of a
[wrapper cookbook][2] which tunes specific node attributes for a
production server deployment.

The [Consul cluster cookbook][14] is provided as an example.

## Advanced Usage
As explained above this cookbook provides Chef primitives in the form
of resource/provider to further manage the install and configuration
of Consul. These primitives are what is used in the default recipe,
and should be used in your own [wrapper cookbooks][2] for more
advanced configurations.

### Configuration
It is very important to understand that each resource/provider has
defaults for some properties. Any changes to a resource's default
properties may need to be also changed in other resources. The best
example is the Consul configuration directory.

In the example below we're going to change the configuration file from
the default (/etc/consul.json) to one that may be on a special volume.
It is obvious that we need to change the path where `consul_config`
writes its file to, but it is less obvious that this needs to be
passed into `consul_service`.

Inside of a recipe in your [wrapper cookbook][2] you'll want to do
something like the following block of code. It uses the validated
input from the configuration resource and passes it into the service
resource. This ensures that we're using the _same data_.
```ruby
config = consul_config '/data/consul/default.json'
consul_service 'consul' do
  config_file config.path
end
```
### Watches/Definitions
In order to provide an idempotent implementation of Consul
watches and definitions. We write these out as
a separate configuration file in the JSON file format. The provider
for both of these resources are identical in functionality.

Below is an example of writing a [Consul service definition][11] for
the master instance of Redis. We pass in several parameters and tell
the resource to notify the proper instance of the Consul service to
reload.
```ruby
consul_definition 'redis' do
  type 'service'
  parameters(tags: %w{master}, address: '127.0.0.1', port: 6379, interval: '30s')
  notifies :reload, 'consul_service[consul]', :delayed
end
```

A [check definition][12] can easily be added as well. You simply have
to change the type and pass in the correct parameters. The definition
below checks memory utilization using a script on a ten second interval.
```ruby
consul_definition 'mem-util' do
  type 'check'
  parameters(script: '/usr/local/bin/check_mem.py', interval: '10s')
  notifies :reload, 'consul_service[consul]', :delayed
end
```

Finally, a [watch][9] is created below to tell the agent to monitor to
see if an application has been deployed. Once that application is
deployed a script is run locally. This can be used, for example, as a
lazy way to clear a HTTP disk cache.
```ruby
consul_watch 'app-deploy' do
  type 'event'
  parameters(handler: '/usr/local/bin/clear-disk-cache.sh')
  notifies :reload, 'consul_service[consul]', :delayed
end
```

A keen eye would notice that we are _delaying the reload of the Consul
service instance_. The reason we do this is to minimize the number of
times we need to tell Consul to actually reload configurations. If
there are several definitions this may save a little time off your
Chef run.

### Execute
The command-line agent provides a mechanism to facilitate remote
execution. For example, this can be used to run the `uptime` command
across your fleet of nodes which are hosting a particular API service.
```ruby
consul_execute 'uptime' do
  options(service: 'api')
end
```

All of the [options available on the command-line][12] can be passed
into the resource. This could potentially be a *very dangerous*
operation. You should absolutely understand what you are doing. By the
nature of this command it is _impossible_ for it to be idempotent.

### UI

`consul_ui` resource can be used to download and extract the 
[consul web UI](https://www.consul.io/intro/getting-started/ui.html).
It can be done with a block like this:

```ruby
consul_ui 'consul-ui' do
  owner node['consul']['service_user']
  group node['consul']['service_group']
  version node['consul']['version']
end
```

Assuming consul version `0.5.2` above block would create `/srv/consul-ui/0.5.2`
and symlink `/srv/consul-ui/current`.

It does not change agent's configuration by itself. 
`consul_config` resource should be modified explicitly in order to host the web page.

```ruby
consul_config 'consul' do
  ...
  ui_dir '/srv/consul-ui/current/dist'
end
```

This is optional, because consul UI can be hosted by any web server.


[0]: http://blog.vialstudios.com/the-environment-cookbook-pattern/#theapplicationcookbook
[1]: http://consul.io
[2]: http://blog.vialstudios.com/the-environment-cookbook-pattern#thewrappercookbook
[3]: http://blog.vialstudios.com/the-environment-cookbook-pattern#thelibrarycookbook
[4]: https://github.com/johnbellone/libartifact-cookbook
[5]: https://github.com/poise/poise
[6]: https://github.com/poise/poise-service
[7]: https://github.com/skottler/selinux
[8]: https://github.com/test-kitchen/test-kitchen
[9]: https://consul.io/docs/agent/watches.html
[10]: https://consul.io/docs/agent/services.html
[11]: https://consul.io/docs/agent/checks.html
[12]: https://consul.io/docs/commands/exec.html
[13]:
[14]: https://github.com/johnbellone/consul-cluster-cookbook
