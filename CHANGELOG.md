# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## Unreleased
    - [PR#259] Add windows support. [@Ginja](https://github.com/Ginja)

## 1.3.1
### Bug Fixes
- Fixes constraints on cookbooks for builds.
- Modifies chef-vault cookbook entry to use upstream.

## 1.3.0
### Enhancements
    - Travis builds now use new container infrastructure.
    - [PR#215] Add new resource for managing Consul UI service.
    - [PR#219] Adds support to configuration for recursor. [@fumimaron9](https://github.com/fumimaron9)
    - [PR#224] Adds support to configuration resource for Join WAN. [@justintime](https://github.com/justintime)
    - [PR#228] Default recipe now opens up UDP firewall rules. [@twmb](https://github.com/twmb)
### Bug Fixes
    - [PR#210] Adds all types of Consul watches. [@scalp42](https://github.com/scalp42)
    - [PR#211] Service resource disable action deletes configuration. [@scalp42](https://github.com/scalp42)
    - [PR#212] Fixes issues while defining multiple service checks. [@scalp42](https://github.com/scalp42)
    - [PR#213] Service Resource - Disable action doesn't delete directory. [@scalp42](https://github.com/scalp42)
    - [PR#221] Updates firewall cookbook dependency version. [@lmickh](https://github.com/lmickh)
    - [PR#222] Fixes syntax for Consul watch resource configuration. [@wk8](https://github.com/wk8)
    - [PR#223] Skips SELinux recipe on non-Linux platforms. [@kamaradclimber](https://github.com/kamaradclimber)
    - [PR#227] Fixes definition resource to be able to override name. [@tomzo](https://github.com/tomzo)
`
## 0.10.0
### Enhancements
    - Node attribute for specifying Consul log file. [@darron](https://github.com/darron)
    - Recipe no longer tries to create directories twice. [@tiwilliam](https://github.com/tiwilliam)
    - Add packagecloud install method. [@darron](https://github.com/darron)
    - Add 'rejoin_after_leave' option. [@arodd](https://github.com/arodd)
    - Add LWRP for services watch. [@hirocaster](https://github.com/hirocaster)
### Bug Fixes
    - [PR#152] Remove +x permissions on upstart/systemd configs. [@dpkp](https://github.com/dpkp)
    - [PR#158] Fix sysvinit script by not quoting commands. [@hatchetation](https://github.com/hatchetation)
    - [PR#172] Adds missing bracket to restart subscription. [@YuukiARIA](https://github.com/YuukiARIA)
    - [PR#178] Ensures GOMAXPROCS is at least 2. [@tgwizard](https://github.com/tgwizard)

## 0.9.1
### Bug Fixes
    - Locks to Chef 11 compatible version of libarchive cookbook.

## 0.9
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

## 0.8.3
### Bug Fixes
    - Export GOMAXPROCS when using runit service style.

## 0.8.2
### Bug Fixes
    - Sets GOMAXPROCS when using runit service style.

## 0.8.1
### Bug Fixes
    - Vanilla init script now points to the proper Consul binary and data dir.

## 0.8
### Enhancements
    - Upgrading from one version to another of Consul is now supported.
    - Restarts after upgrade.
### Bug Fixes
    - Partial convergeances will now gracefully recover on the next chef run.
    - Upstart will now respawn Consul on crash.
    - It is no longer possible to set an invalid install method.

## 0.7
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

[PR#259]: https://github.com/johnbellone/consul-cookbook/pull/259
[PR#228]: https://github.com/johnbellone/consul-cookbook/pull/228
[PR#227]: https://github.com/johnbellone/consul-cookbook/pull/227
[PR#224]: https://github.com/johnbellone/consul-cookbook/pull/224
[PR#223]: https://github.com/johnbellone/consul-cookbook/pull/223
[PR#222]: https://github.com/johnbellone/consul-cookbook/pull/222
[PR#221]: https://github.com/johnbellone/consul-cookbook/pull/221
[PR#219]: https://github.com/johnbellone/consul-cookbook/pull/219
[PR#215]: https://github.com/johnbellone/consul-cookbook/pull/215
[PR#213]: https://github.com/johnbellone/consul-cookbook/pull/213
[PR#212]: https://github.com/johnbellone/consul-cookbook/pull/212
[PR#211]: https://github.com/johnbellone/consul-cookbook/pull/211
[PR#210]: https://github.com/johnbellone/consul-cookbook/pull/210
[PR#178]: https://github.com/johnbellone/consul-cookbook/pull/178
[PR#172]: https://github.com/johnbellone/consul-cookbook/pull/172
[PR#158]: https://github.com/johnbellone/consul-cookbook/pull/158
[PR#152]: https://github.com/johnbellone/consul-cookbook/pull/152
