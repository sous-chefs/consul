# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## 1.4.3
### Bug Fixes
- [PR#272][PR272] Fix custom ACL resource Diplomat gem parameters.

## 1.4.2
### Enhancements
- [PR#275][PR275] Add integration tests for Windows.

### Bug Fixes
- [PR#274][PR274] Fix start issues with EL5.
- [PR#273][PR273] Fix data directory attribute for Windows.

## 1.4.1
### Bug Fixes
- [PR#271][PR271] Fix service user not having /bin/bash shell.

## 1.4
### Enhancements
This release includes general improvements to the build process and
adds newer versions of EL6 and EL7 to the build matrix. Additionally,
the following enhancements:
- [PR#259][PR259] Add windows support. [@Ginja](https://github.com/Ginja)
- [PR#266][PR266] Add custom template for sysvinit. [@legal90](https://github.com/legal90)
- [PR#264][PR264] Bump default version to Consul 0.6.3.
- [PR#267][PR267] Add parameters for retry join configuration.

### Bug Fixes
- [PR#226][PR226] Fix systemd unit starting before network.
- [PR#235][PR235] Fix EL6 service not starting at boot.
- [PR#269][PR269] Fix duplicate data directory attributes.
- [PR#270][PR270] Fix regression of absolute path for systemd unit.

## 1.3.1
### Bug Fixes
- Fixes constraints on cookbooks for builds.
- Modifies chef-vault cookbook entry to use upstream.

## 1.3
### Enhancements
- Travis builds now use new container infrastructure.
- [PR#215][PR259] Add new resource for managing Consul UI service.
- [PR#219][PR219] Adds support to configuration for recursor. [@fumimaron9](https://github.com/fumimaron9)
- [PR#224][PR224] Adds support to configuration resource for Join WAN. [@justintime](https://github.com/justintime)
- [PR#228][PR228] Default recipe now opens up UDP firewall rules. [@twmb](https://github.com/twmb)

### Bug Fixes
- [PR#210][PR210] Adds all types of Consul watches. [@scalp42](https://github.com/scalp42)
- [PR#211][PR211] Service resource disable action deletes configuration. [@scalp42](https://github.com/scalp42)
- [PR#212][PR212] Fixes issues while defining multiple service checks. [@scalp42](https://github.com/scalp42)
- [PR#213][PR213] Service Resource - Disable action doesn't delete directory. [@scalp42](https://github.com/scalp42)
- [PR#221][PR221] Updates firewall cookbook dependency version. [@lmickh](https://github.com/lmickh)
- [PR#222][PR222] Fixes syntax for Consul watch resource configuration. [@wk8](https://github.com/wk8)
- [PR#223][PR223] Skips SELinux recipe on non-Linux platforms. [@kamaradclimber](https://github.com/kamaradclimber)
- [PR#227][PR227] Fixes definition resource to be able to override name. [@tomzo](https://github.com/tomzo)
`
## 0.10.0
### Enhancements
- Node attribute for specifying Consul log file. [@darron](https://github.com/darron)
- Recipe no longer tries to create directories twice. [@tiwilliam](https://github.com/tiwilliam)
- Add packagecloud install method. [@darron](https://github.com/darron)
- Add 'rejoin_after_leave' option. [@arodd](https://github.com/arodd)
- Add LWRP for services watch. [@hirocaster](https://github.com/hirocaster)
### Bug Fixes
- [PR#152][PR152] Remove +x permissions on upstart/systemd configs. [@dpkp](https://github.com/dpkp)
- [PR#158][PR158] Fix sysvinit script by not quoting commands. [@hatchetation](https://github.com/hatchetation)
- [PR#172][PR172] Adds missing bracket to restart subscription. [@YuukiARIA](https://github.com/YuukiARIA)
- [PR#178][PR178] Ensures GOMAXPROCS is at least 2. [@tgwizard](https://github.com/tgwizard)

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

[PR275]: https://github.com/johnbellone/consul-cookbook/pull/275
[PR274]: https://github.com/johnbellone/consul-cookbook/pull/274
[PR273]: https://github.com/johnbellone/consul-cookbook/pull/273
[PR272]: https://github.com/johnbellone/consul-cookbook/pull/272
[PR271]: https://github.com/johnbellone/consul-cookbook/pull/271
[PR270]: https://github.com/johnbellone/consul-cookbook/pull/270
[PR269]: https://github.com/johnbellone/consul-cookbook/pull/269
[PR267]: https://github.com/johnbellone/consul-cookbook/pull/267
[PR266]: https://github.com/johnbellone/consul-cookbook/pull/266
[PR264]: https://github.com/johnbellone/consul-cookbook/pull/264
[PR259]: https://github.com/johnbellone/consul-cookbook/pull/259
[PR235]: https://github.com/johnbellone/consul-cookbook/pull/235
[PR228]: https://github.com/johnbellone/consul-cookbook/pull/228
[PR227]: https://github.com/johnbellone/consul-cookbook/pull/227
[PR226]: https://github.com/johnbellone/consul-cookbook/pull/226
[PR224]: https://github.com/johnbellone/consul-cookbook/pull/224
[PR223]: https://github.com/johnbellone/consul-cookbook/pull/223
[PR222]: https://github.com/johnbellone/consul-cookbook/pull/222
[PR221]: https://github.com/johnbellone/consul-cookbook/pull/221
[PR219]: https://github.com/johnbellone/consul-cookbook/pull/219
[PR215]: https://github.com/johnbellone/consul-cookbook/pull/215
[PR213]: https://github.com/johnbellone/consul-cookbook/pull/213
[PR212]: https://github.com/johnbellone/consul-cookbook/pull/212
[PR211]: https://github.com/johnbellone/consul-cookbook/pull/211
[PR210]: https://github.com/johnbellone/consul-cookbook/pull/210
[PR178]: https://github.com/johnbellone/consul-cookbook/pull/178
[PR172]: https://github.com/johnbellone/consul-cookbook/pull/172
[PR158]: https://github.com/johnbellone/consul-cookbook/pull/158
[PR152]: https://github.com/johnbellone/consul-cookbook/pull/152
