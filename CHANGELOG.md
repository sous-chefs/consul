# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

## [1.3.1]
### Bug Fixes
- Fixes constraints on cookbooks for builds.
- Modifies chef-vault cookbook entry to use upstream.

## [1.3.0]
### Enhancements
    - Travis builds now use new container infrastructure.
    - #215: Adds new resource for managing Consul UI service.
    - #219: Adds support to configuration for recursor. [@fumimaron9](https://github.com/fumimaron9)
    - #224: Adds support to configuration resource for Join WAN. [@justintime](https://github.com/justintime)
    - #228: Default recipe now opens up UDP firewall rules. [@twmb](https://github.com/twmb)
### Bug Fixes
    - #210: Adds all types of Consul watches. [@scalp42](https://github.com/scalp42)
    - #211: Service resource disable action deletes configuration. [@scalp42](https://github.com/scalp42)
    - #212: Fixes issues while defining multiple service checks. [@scalp42](https://github.com/scalp42)
    - #213: Service Resource - Disable action doesn't delete directory. [@scalp42](https://github.com/scalp42)
    - #221: Updates firewall cookbook dependency version. [@lmickh](https://github.com/lmickh)
    - #222: Fixes syntax for Consul watch resource configuration. [@wk8](https://github.com/wk8)
    - #223: Skips SELinux recipe on non-Linux platforms. [@kamaradclimber](https://github.com/kamaradclimber)
    - #227: Fixes definition resource to be able to override name. [@tomzo](https://github.com/tomzo)
`
## [0.10.0]
### Enhancements
    - Node attribute for specifying Consul log file. [@darron](https://github.com/darron)
    - Recipe no longer tries to create directories twice. [@tiwilliam](https://github.com/tiwilliam)
    - Add packagecloud install method. [@darron](https://github.com/darron)
    - Add 'rejoin_after_leave' option. [@arodd](https://github.com/arodd)
    - Add LWRP for services watch. [@hirocaster](https://github.com/hirocaster)
### Bug Fixes
    - #152 Remove +x permissions on upstart/systemd configs. [@dpkp](https://github.com/dpkp)
    - #158 Fix sysvinit script by not quoting commands. [@hatchetation](https://github.com/hatchetation)
    - #172 Adds missing bracket to restart subscription. [@YuukiARIA](https://github.com/YuukiARIA)
    - #178 Ensures GOMAXPROCS is at least 2. [@tgwizard](https://github.com/tgwizard)

## [0.9.1]
### Bug Fixes
    - Locks to Chef 11 compatible version of libarchive cookbook.

## [0.9.0]
### Enhancements
    - Adds support for publishing to statsd URL. [@akerekes](https://github.com/akerekes)
    - Adds support for Arch Linux. ([@logankoester](https://github.com/logankoester))
    - Adds systemd init style. [@logankoester](https://github.com/logankoester)
    - Adds support for Consul HTTP checks. [@gavinheavyside](https://github.com/gavinheavyside)
    - Bump default Consul installed version to 0.5.0
### Bug Fixes
    - Remove hard dependency on chef-provisioning cookbook.
    - Sets correct ownership to Consul run user/group on service directories. [@thedebugger](https://github.com/thedebugger)
    - Removes support for EL5 (CentOS 5) and Ubuntu 10.04.

## [0.8.3]
### Bug Fixes
    - Export GOMAXPROCS when using runit service style.

## [0.8.2]
### Bug Fixes
    - Sets GOMAXPROCS when using runit service style.

## [0.8.1]
### Bug Fixes
    - Vanilla init script now points to the proper Consul binary and data dir.

## [0.8.0]
### Enhancements
    - Upgrading from one version to another of Consul is now supported.
    - Restarts after upgrade.
### Bug Fixes
    - Partial convergeances will now gracefully recover on the next chef run.
    - Upstart will now respawn Consul on crash.
    - It is no longer possible to set an invalid install method.

## [0.7.0]
### Enhancements
    - Adds cluster recipe for easily provisioning new Consul clusters.
    - Adds support for additional options for service_config.
    - Adds support for Ubuntu 10.04.
    - Allows custom data bags for Consul encrypt.
    - Bumps support for golang cookbook to 1.4.
    - Adds `consul/retry_on_join` attribute.
    - Adds consul_service_watch LWRP.
### Bug Fixes
    - Reloading the Consul service when using runit init style.

[Unreleased]: https://github.com/johnbellone/consul-cookbook/compare/v1.3.2...HEAD
[1.3.1]: https://github.com/johnbellone/consul-cookbook/compare/v1.3.1...HEAD
[1.3.0]: https://github.com/johnbellone/consul-cookbook/compare/v1.3.0...HEAD
[0.10.0]: https://github.com/johnbellone/consul-cookbook/compare/v0.10.0...HEAD
[0.9.1]: https://github.com/johnbellone/consul-cookbook/compare/v0.9.1...HEAD
[0.9.0]: https://github.com/johnbellone/consul-cookbook/compare/v0.9.0...HEAD
[0.8.3]: https://github.com/johnbellone/consul-cookbook/compare/v0.8.3...HEAD
[0.8.2]: https://github.com/johnbellone/consul-cookbook/compare/v0.8.2...HEAD
[0.8.1]: https://github.com/johnbellone/consul-cookbook/compare/v0.8.1...HEAD
[0.8.0]: https://github.com/johnbellone/consul-cookbook/compare/v0.8.0...HEAD
[0.7.0]: https://github.com/johnbellone/consul-cookbook/compare/v0.7.0...HEAD

[1]: http://consul.io
[2]: https://github.com/reset
[3]: https://github.com/sethvargo/chefspec
[4]: http://acrmp.github.io/foodcritic/
[5]: https://github.com/romesh-mccullough
[6]: https://github.com/bbatsov/rubocop
[7]: https://github.com/opscode/chef-provisioning
[8]: http://www.consul.io/docs/commands/watch.html
[9]: https://github.com/ericfode
