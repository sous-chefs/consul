# Change Log

## [v2.1.1](https://github.com/johnbellone/consul-cookbook/tree/v2.1.1)

[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v2.1.0...v2.1.1)

**Closed issues:**

- Documentation for Data Bag Setup [\#238](https://github.com/johnbellone/consul-cookbook/issues/238)

**Merged pull requests:**

- Fix log file permissions on RHEL-like systems [\#304](https://github.com/johnbellone/consul-cookbook/pull/304) ([legal90](https://github.com/legal90))
- Add missing unix\_sockets config [\#302](https://github.com/johnbellone/consul-cookbook/pull/302) ([spheromak](https://github.com/spheromak))
- Fixed Windows installation issue [\#300](https://github.com/johnbellone/consul-cookbook/pull/300) ([Ginja](https://github.com/Ginja))
- Clean up chef vault [\#299](https://github.com/johnbellone/consul-cookbook/pull/299) ([shortdudey123](https://github.com/shortdudey123))

## [v2.1.0](https://github.com/johnbellone/consul-cookbook/tree/v2.1.0) (2016-03-18)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v2.0.0...v2.1.0)

**Closed issues:**

- no more web ui? [\#297](https://github.com/johnbellone/consul-cookbook/issues/297)
- Windows 2012 R2 Issue [\#295](https://github.com/johnbellone/consul-cookbook/issues/295)

**Merged pull requests:**

- Add custom resource for installing the Web UI. [\#298](https://github.com/johnbellone/consul-cookbook/pull/298) ([johnbellone](https://github.com/johnbellone))
- Replace nssm restart by powershell commands [\#282](https://github.com/johnbellone/consul-cookbook/pull/282) ([kamaradclimber](https://github.com/kamaradclimber))

## [v2.0.0](https://github.com/johnbellone/consul-cookbook/tree/v2.0.0) (2016-03-17)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.5.0...v2.0.0)

**Implemented enhancements:**

- sysvinit.service.erb has the consul service log to /dev/null [\#284](https://github.com/johnbellone/consul-cookbook/issues/284)
- Refactor the population of TLS files to wrapper cookbooks? [\#247](https://github.com/johnbellone/consul-cookbook/issues/247)

**Fixed bugs:**

- Updating consul version does not restart consul [\#251](https://github.com/johnbellone/consul-cookbook/issues/251)

**Closed issues:**

- Key not found: "consul\_0.6.3\_linux\_amd64" [\#294](https://github.com/johnbellone/consul-cookbook/issues/294)
- where does consul installed through this cookbook write its logs  [\#290](https://github.com/johnbellone/consul-cookbook/issues/290)
- restart\_on\_update considered harmful [\#288](https://github.com/johnbellone/consul-cookbook/issues/288)
- Use 'system' attribute when adding consul user & group [\#287](https://github.com/johnbellone/consul-cookbook/issues/287)
- client config not being created [\#217](https://github.com/johnbellone/consul-cookbook/issues/217)
- AWS Autoscaling [\#192](https://github.com/johnbellone/consul-cookbook/issues/192)

**Merged pull requests:**

- Add debian-7.9 and debian-7.2 to the test matrix. [\#293](https://github.com/johnbellone/consul-cookbook/pull/293) ([johnbellone](https://github.com/johnbellone))
- Add support for writing logs to /var/log/consul.log. [\#292](https://github.com/johnbellone/consul-cookbook/pull/292) ([johnbellone](https://github.com/johnbellone))
- Adds custom resource for installing Consul. [\#291](https://github.com/johnbellone/consul-cookbook/pull/291) ([johnbellone](https://github.com/johnbellone))

## [v1.5.0](https://github.com/johnbellone/consul-cookbook/tree/v1.5.0) (2016-03-07)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.4.3...v1.5.0)

**Closed issues:**

- consul\_acl \(or Diplomat gem\) misbehaving [\#283](https://github.com/johnbellone/consul-cookbook/issues/283)
- Service definition with an integrated check [\#280](https://github.com/johnbellone/consul-cookbook/issues/280)
- Atlas Integration go away with v1? [\#277](https://github.com/johnbellone/consul-cookbook/issues/277)
- default\['consul'\]\['config'\]\['bag\_name'\] broke consul\_config [\#276](https://github.com/johnbellone/consul-cookbook/issues/276)

**Merged pull requests:**

- changing the consul\_definition tags to an array [\#286](https://github.com/johnbellone/consul-cookbook/pull/286) ([fstradiotti](https://github.com/fstradiotti))
- GH-277 - Adding in atlas centric configuration options [\#285](https://github.com/johnbellone/consul-cookbook/pull/285) ([jrnt30](https://github.com/jrnt30))
- adding service definition with integrated check to readme [\#281](https://github.com/johnbellone/consul-cookbook/pull/281) ([fstradiotti](https://github.com/fstradiotti))
- Fix "ConsulAcl" provider when specified "id" doesn't exist [\#278](https://github.com/johnbellone/consul-cookbook/pull/278) ([legal90](https://github.com/legal90))

## [v1.4.3](https://github.com/johnbellone/consul-cookbook/tree/v1.4.3) (2016-02-08)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.4.2...v1.4.3)

**Merged pull requests:**

- Correct acl creation [\#272](https://github.com/johnbellone/consul-cookbook/pull/272) ([kamaradclimber](https://github.com/kamaradclimber))

## [v1.4.2](https://github.com/johnbellone/consul-cookbook/tree/v1.4.2) (2016-02-08)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.4.1...v1.4.2)

**Fixed bugs:**

- Windows Consul service does not start up [\#273](https://github.com/johnbellone/consul-cookbook/issues/273)

**Merged pull requests:**

- Windows data path [\#275](https://github.com/johnbellone/consul-cookbook/pull/275) ([gdavison](https://github.com/gdavison))
- Fix Startup Issue [\#274](https://github.com/johnbellone/consul-cookbook/pull/274) ([Ginja](https://github.com/Ginja))

## [v1.4.1](https://github.com/johnbellone/consul-cookbook/tree/v1.4.1) (2016-02-05)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.4.0...v1.4.1)

**Fixed bugs:**

- consul service user /bin/false shell ? [\#271](https://github.com/johnbellone/consul-cookbook/issues/271)

**Closed issues:**

- New version? [\#258](https://github.com/johnbellone/consul-cookbook/issues/258)
- consul\_ui resource does not work [\#255](https://github.com/johnbellone/consul-cookbook/issues/255)

## [v1.4.0](https://github.com/johnbellone/consul-cookbook/tree/v1.4.0) (2016-02-03)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.3.1...v1.4.0)

**Implemented enhancements:**

- Basis for selinux set to disabled [\#242](https://github.com/johnbellone/consul-cookbook/issues/242)
- Consul ACL custom resource [\#240](https://github.com/johnbellone/consul-cookbook/issues/240)
- Windows install on 64-bit fails [\#236](https://github.com/johnbellone/consul-cookbook/issues/236)
- Added Windows Support [\#259](https://github.com/johnbellone/consul-cookbook/pull/259) ([Ginja](https://github.com/Ginja))

**Fixed bugs:**

- libarchive error when installing consul on Ubuntu 14.04 [\#241](https://github.com/johnbellone/consul-cookbook/issues/241)
- Unable to override databag attributes [\#239](https://github.com/johnbellone/consul-cookbook/issues/239)
- does not start at boot on CentOS 6 [\#235](https://github.com/johnbellone/consul-cookbook/issues/235)
- Consul systemd unit should wait for network [\#226](https://github.com/johnbellone/consul-cookbook/issues/226)

**Closed issues:**

- Idempotency [\#262](https://github.com/johnbellone/consul-cookbook/issues/262)
- retry\_interval should be a string [\#244](https://github.com/johnbellone/consul-cookbook/issues/244)
- Configuring TLS for RPC [\#230](https://github.com/johnbellone/consul-cookbook/issues/230)
- Question: Configuring Consul [\#229](https://github.com/johnbellone/consul-cookbook/issues/229)
- Update README with what has changed [\#201](https://github.com/johnbellone/consul-cookbook/issues/201)

**Merged pull requests:**

- Use absolute path for consul to satisfy systemd [\#270](https://github.com/johnbellone/consul-cookbook/pull/270) ([sh9189](https://github.com/sh9189))
- Remove duplicated "data\_dir" attribute [\#269](https://github.com/johnbellone/consul-cookbook/pull/269) ([legal90](https://github.com/legal90))
- Added retry WAN parameters [\#267](https://github.com/johnbellone/consul-cookbook/pull/267) ([gdavison](https://github.com/gdavison))
- Add custom template for "sysvinit" service provider [\#266](https://github.com/johnbellone/consul-cookbook/pull/266) ([legal90](https://github.com/legal90))
- Create config files in config\_dir [\#265](https://github.com/johnbellone/consul-cookbook/pull/265) ([gdavison](https://github.com/gdavison))
- Add support of Consul 0.6.3 [\#264](https://github.com/johnbellone/consul-cookbook/pull/264) ([legal90](https://github.com/legal90))
- Added ability to remove nssm parameters [\#263](https://github.com/johnbellone/consul-cookbook/pull/263) ([Ginja](https://github.com/Ginja))
- Add support of "ui" config option [\#261](https://github.com/johnbellone/consul-cookbook/pull/261) ([legal90](https://github.com/legal90))
- Use Consul 0.6.1 [\#260](https://github.com/johnbellone/consul-cookbook/pull/260) ([shaneramey](https://github.com/shaneramey))
- Add ACL support [\#257](https://github.com/johnbellone/consul-cookbook/pull/257) ([bdclark](https://github.com/bdclark))
- Fixes \#242 & Reverts \#253 [\#256](https://github.com/johnbellone/consul-cookbook/pull/256) ([Ginja](https://github.com/Ginja))
- Guard against owning /etc [\#254](https://github.com/johnbellone/consul-cookbook/pull/254) ([bdclark](https://github.com/bdclark))
- Update URL for UI package [\#253](https://github.com/johnbellone/consul-cookbook/pull/253) ([bdclark](https://github.com/bdclark))
- Updated Consul Download URLs [\#252](https://github.com/johnbellone/consul-cookbook/pull/252) ([Ginja](https://github.com/Ginja))
- Updates binary package URL to new hashicorp directory/filename structure [\#250](https://github.com/johnbellone/consul-cookbook/pull/250) ([Fitzsimmons](https://github.com/Fitzsimmons))
- Add a version to poise-boiler to fix Travis [\#249](https://github.com/johnbellone/consul-cookbook/pull/249) ([elyscape](https://github.com/elyscape))
- Add support for Consul 0.6.0 [\#248](https://github.com/johnbellone/consul-cookbook/pull/248) ([elyscape](https://github.com/elyscape))
- Add rejoin\_after\_leave config option [\#246](https://github.com/johnbellone/consul-cookbook/pull/246) ([Ginja](https://github.com/Ginja))
- retry\_interval need to be a string, fixes \#244 [\#245](https://github.com/johnbellone/consul-cookbook/pull/245) ([scalp42](https://github.com/scalp42))
- Improve selinux support [\#243](https://github.com/johnbellone/consul-cookbook/pull/243) ([Ginja](https://github.com/Ginja))
- Update README.md [\#237](https://github.com/johnbellone/consul-cookbook/pull/237) ([jrnt30](https://github.com/jrnt30))
- Adds retry\_join to the available configuration options [\#234](https://github.com/johnbellone/consul-cookbook/pull/234) ([Fitzsimmons](https://github.com/Fitzsimmons))
- flatten the for\_keeps variable to make include? work for tls options [\#233](https://github.com/johnbellone/consul-cookbook/pull/233) ([joerocklin](https://github.com/joerocklin))
- Update README: no interval for service definition [\#232](https://github.com/johnbellone/consul-cookbook/pull/232) ([iroller](https://github.com/iroller))

## [v1.3.1](https://github.com/johnbellone/consul-cookbook/tree/v1.3.1) (2015-10-07)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.3.0...v1.3.1)

**Closed issues:**

- Cut a new release? [\#225](https://github.com/johnbellone/consul-cookbook/issues/225)

## [v1.3.0](https://github.com/johnbellone/consul-cookbook/tree/v1.3.0) (2015-10-07)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.2.0...v1.3.0)

**Implemented enhancements:**

- web UI install missing since 1.0 [\#215](https://github.com/johnbellone/consul-cookbook/issues/215)

**Merged pull requests:**

- include firewall\_rule for udp ports [\#228](https://github.com/johnbellone/consul-cookbook/pull/228) ([twmb](https://github.com/twmb))
- support to specify explicit service name other that filename [\#227](https://github.com/johnbellone/consul-cookbook/pull/227) ([tomzo](https://github.com/tomzo))
- Support for start\_join\_wan [\#224](https://github.com/johnbellone/consul-cookbook/pull/224) ([justintime](https://github.com/justintime))
- Skip SElinux recipe on non linux OSes. [\#223](https://github.com/johnbellone/consul-cookbook/pull/223) ([kamaradclimber](https://github.com/kamaradclimber))
- Fixing the syntax for Consul watches [\#222](https://github.com/johnbellone/consul-cookbook/pull/222) ([wk8](https://github.com/wk8))
- Update firewall dependency [\#221](https://github.com/johnbellone/consul-cookbook/pull/221) ([lmickh](https://github.com/lmickh))
- update consul\_config resource [\#219](https://github.com/johnbellone/consul-cookbook/pull/219) ([fumimaron9](https://github.com/fumimaron9))
- consul\_ui resource [\#218](https://github.com/johnbellone/consul-cookbook/pull/218) ([tomzo](https://github.com/tomzo))
- Add support for advertise\_addr\_wan [\#214](https://github.com/johnbellone/consul-cookbook/pull/214) ([cmann](https://github.com/cmann))
- do not delete consul data dir [\#213](https://github.com/johnbellone/consul-cookbook/pull/213) ([scalp42](https://github.com/scalp42))
- allow to define multiple checks/services [\#212](https://github.com/johnbellone/consul-cookbook/pull/212) ([scalp42](https://github.com/scalp42))
- fix consul\_service disable action [\#211](https://github.com/johnbellone/consul-cookbook/pull/211) ([scalp42](https://github.com/scalp42))
- update watch types [\#210](https://github.com/johnbellone/consul-cookbook/pull/210) ([scalp42](https://github.com/scalp42))

## [v1.2.0](https://github.com/johnbellone/consul-cookbook/tree/v1.2.0) (2015-08-24)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.1.1...v1.2.0)

**Closed issues:**

- How to pass extra options since refactor? [\#209](https://github.com/johnbellone/consul-cookbook/issues/209)
- golang upgrade? [\#207](https://github.com/johnbellone/consul-cookbook/issues/207)

**Merged pull requests:**

- Remove opinionated lock on golang [\#208](https://github.com/johnbellone/consul-cookbook/pull/208) ([scalp42](https://github.com/scalp42))

## [v1.1.1](https://github.com/johnbellone/consul-cookbook/tree/v1.1.1) (2015-08-13)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.1.0...v1.1.1)

## [v1.1.0](https://github.com/johnbellone/consul-cookbook/tree/v1.1.0) (2015-08-13)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.0.0...v1.1.0)

**Closed issues:**

- regression of allowing http checks [\#206](https://github.com/johnbellone/consul-cookbook/issues/206)
- Write more comprehensive unit tests. [\#202](https://github.com/johnbellone/consul-cookbook/issues/202)
- Update README with new, detailed examples. [\#200](https://github.com/johnbellone/consul-cookbook/issues/200)

## [v1.0.0](https://github.com/johnbellone/consul-cookbook/tree/v1.0.0) (2015-08-06)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.11.1...v1.0.0)

**Implemented enhancements:**

- Multiple checks for one service [\#173](https://github.com/johnbellone/consul-cookbook/issues/173)
- Add HWRPs for installing and managing consul. [\#126](https://github.com/johnbellone/consul-cookbook/pull/126) ([johnbellone](https://github.com/johnbellone))

**Merged pull requests:**

- Fix directory permissions on config\_dir and data\_dir [\#205](https://github.com/johnbellone/consul-cookbook/pull/205) ([ewr](https://github.com/ewr))
- Remove references to "quicks\_mode" in JSON generation [\#204](https://github.com/johnbellone/consul-cookbook/pull/204) ([ewr](https://github.com/ewr))

## [v0.11.1](https://github.com/johnbellone/consul-cookbook/tree/v0.11.1) (2015-07-25)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.11.0...v0.11.1)

**Merged pull requests:**

- Adding open files configuration for Upstart. [\#199](https://github.com/johnbellone/consul-cookbook/pull/199) ([darron](https://github.com/darron))
- Readme fix [\#198](https://github.com/johnbellone/consul-cookbook/pull/198) ([jedineeper](https://github.com/jedineeper))

## [v0.11.0](https://github.com/johnbellone/consul-cookbook/tree/v0.11.0) (2015-07-23)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.10.1...v0.11.0)

**Implemented enhancements:**

- Windows: resolved merge conflicts and added tests [\#196](https://github.com/johnbellone/consul-cookbook/pull/196) ([gdavison](https://github.com/gdavison))

**Fixed bugs:**

- chown resource executes every run, even when not changing anything [\#191](https://github.com/johnbellone/consul-cookbook/issues/191)
- Sensitivity to HUP during launch [\#125](https://github.com/johnbellone/consul-cookbook/issues/125)

**Closed issues:**

- Anything chef-brigade can do to help? [\#197](https://github.com/johnbellone/consul-cookbook/issues/197)
- Kitchen tests failing on master \(commit a8d3060\) [\#194](https://github.com/johnbellone/consul-cookbook/issues/194)

**Merged pull requests:**

- A couple test fixes [\#195](https://github.com/johnbellone/consul-cookbook/pull/195) ([gdavison](https://github.com/gdavison))

## [v0.10.1](https://github.com/johnbellone/consul-cookbook/tree/v0.10.1) (2015-07-10)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.10...v0.10.1)

**Implemented enhancements:**

- consul systemd hangs at 'create symlink at /etc/service/consul to /etc/sv/consul' on Centos70 [\#168](https://github.com/johnbellone/consul-cookbook/issues/168)
- ui-dir not in config template [\#131](https://github.com/johnbellone/consul-cookbook/issues/131)
- Add support for Consul 0.5.0 and Atlas auto-join [\#135](https://github.com/johnbellone/consul-cookbook/pull/135) ([shanesveller](https://github.com/shanesveller))

**Fixed bugs:**

- Error executing action `extract` on resource 'libarchive\_file\[consul.zip\]' [\#170](https://github.com/johnbellone/consul-cookbook/issues/170)
- Missing package on RHEL7 AWS [\#165](https://github.com/johnbellone/consul-cookbook/issues/165)
- Databag item 'ca\_file' misnamed [\#124](https://github.com/johnbellone/consul-cookbook/issues/124)
- Wrong user used for services when using upstart [\#96](https://github.com/johnbellone/consul-cookbook/issues/96)

**Closed issues:**

- Release Tag for 0.10.0 [\#187](https://github.com/johnbellone/consul-cookbook/issues/187)
- HTML tables are garbage, use markdown [\#186](https://github.com/johnbellone/consul-cookbook/issues/186)
- Missing checksum for 0.5.2 [\#185](https://github.com/johnbellone/consul-cookbook/issues/185)
- Windows support [\#184](https://github.com/johnbellone/consul-cookbook/issues/184)
- Question - How to use consul\_check [\#182](https://github.com/johnbellone/consul-cookbook/issues/182)
- Gossip/TLS encryption node attributes still requires consul data\_bag, encrypt item, secret [\#151](https://github.com/johnbellone/consul-cookbook/issues/151)
- `server` v `cluster` semantics unclear to new user / "Getting Started" under-discoverable [\#149](https://github.com/johnbellone/consul-cookbook/issues/149)

**Merged pull requests:**

- Separate install from service [\#190](https://github.com/johnbellone/consul-cookbook/pull/190) ([joshgarnett](https://github.com/joshgarnett))
- use node array to refer to variables [\#189](https://github.com/johnbellone/consul-cookbook/pull/189) ([jedineeper](https://github.com/jedineeper))
- Adding GOMAXPROCS support for systemd. [\#188](https://github.com/johnbellone/consul-cookbook/pull/188) ([joshgarnett](https://github.com/joshgarnett))
- Refactor start and stop timeouts in consul-init [\#161](https://github.com/johnbellone/consul-cookbook/pull/161) ([jon918](https://github.com/jon918))

## [v0.10](https://github.com/johnbellone/consul-cookbook/tree/v0.10) (2015-06-04)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.10.0...v0.10)

## [v0.10.0](https://github.com/johnbellone/consul-cookbook/tree/v0.10.0) (2015-06-04)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.9.1...v0.10.0)

**Implemented enhancements:**

- Add packages install method. [\#180](https://github.com/johnbellone/consul-cookbook/pull/180) ([darron](https://github.com/darron))
- Add LWRP services watch [\#155](https://github.com/johnbellone/consul-cookbook/pull/155) ([hirocaster](https://github.com/hirocaster))

**Closed issues:**

- Question - How to do different configs on different servers [\#177](https://github.com/johnbellone/consul-cookbook/issues/177)
- consul::ui doesn't start with UI process [\#175](https://github.com/johnbellone/consul-cookbook/issues/175)
- Broken SysVinit script -- Consul fails to start on RHEL platforms \(Amazon Linux, CentOS, etc.\) [\#150](https://github.com/johnbellone/consul-cookbook/issues/150)

**Merged pull requests:**

- Don't try to create directories twice [\#183](https://github.com/johnbellone/consul-cookbook/pull/183) ([tiwilliam](https://github.com/tiwilliam))
- Fixes typo in readme [\#181](https://github.com/johnbellone/consul-cookbook/pull/181) ([spuder](https://github.com/spuder))
- Be able to move the log file with an attribute. [\#179](https://github.com/johnbellone/consul-cookbook/pull/179) ([darron](https://github.com/darron))
- Ensure GOMAXPROCS is at least 2 [\#178](https://github.com/johnbellone/consul-cookbook/pull/178) ([tgwizard](https://github.com/tgwizard))
- consul 0.5.2 checksums, changed default version to install [\#176](https://github.com/johnbellone/consul-cookbook/pull/176) ([tomzo](https://github.com/tomzo))
- Add missing bracket [\#172](https://github.com/johnbellone/consul-cookbook/pull/172) ([YuukiARIA](https://github.com/YuukiARIA))
- Add version 0.5.1 consul [\#171](https://github.com/johnbellone/consul-cookbook/pull/171) ([hirocaster](https://github.com/hirocaster))
- Update README.md [\#167](https://github.com/johnbellone/consul-cookbook/pull/167) ([berniedurfee-ge](https://github.com/berniedurfee-ge))
- Add a Gitter chat badge to README.md [\#166](https://github.com/johnbellone/consul-cookbook/pull/166) ([gitter-badger](https://github.com/gitter-badger))
- Adding rejoin after leave for auto cluster remediation. [\#163](https://github.com/johnbellone/consul-cookbook/pull/163) ([arodd](https://github.com/arodd))
- README refers to client\_addr as client\_address [\#162](https://github.com/johnbellone/consul-cookbook/pull/162) ([logankoester](https://github.com/logankoester))
- Bump default version mentioned in README.me  [\#160](https://github.com/johnbellone/consul-cookbook/pull/160) ([anoldguy](https://github.com/anoldguy))
- Fixes typo in my username \(CHANGELOG\) [\#159](https://github.com/johnbellone/consul-cookbook/pull/159) ([logankoester](https://github.com/logankoester))
- Fix SysVinit script [\#158](https://github.com/johnbellone/consul-cookbook/pull/158) ([hatchetation](https://github.com/hatchetation))
- Upstart and systemd config files do not need +x permissions [\#152](https://github.com/johnbellone/consul-cookbook/pull/152) ([dpkp](https://github.com/dpkp))

## [v0.9.1](https://github.com/johnbellone/consul-cookbook/tree/v0.9.1) (2015-03-30)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/0.9.0...v0.9.1)

**Merged pull requests:**

- Lock libarchive cookbook version to maintain Chef 11 compatibility [\#156](https://github.com/johnbellone/consul-cookbook/pull/156) ([agperson](https://github.com/agperson))

## [0.9.0](https://github.com/johnbellone/consul-cookbook/tree/0.9.0) (2015-03-17)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.8.3...0.9.0)

**Implemented enhancements:**

- Purpose yum-repoforge? [\#120](https://github.com/johnbellone/consul-cookbook/issues/120)
- add statsd support [\#114](https://github.com/johnbellone/consul-cookbook/pull/114) ([akerekes](https://github.com/akerekes))

**Closed issues:**

- Consul fails to restart with access denied error if the consul user is change [\#140](https://github.com/johnbellone/consul-cookbook/issues/140)
- Is the chef-provisioning cookbook a dependency? [\#139](https://github.com/johnbellone/consul-cookbook/issues/139)
- chef-provisioning should not be a dependency [\#137](https://github.com/johnbellone/consul-cookbook/issues/137)
- Add 0.5.0 checksums [\#136](https://github.com/johnbellone/consul-cookbook/issues/136)
- consul::ui recipe is failing to converge with Errno::EISDIR [\#133](https://github.com/johnbellone/consul-cookbook/issues/133)

**Merged pull requests:**

- Update for 0.5.0 [\#148](https://github.com/johnbellone/consul-cookbook/pull/148) ([webcoyote](https://github.com/webcoyote))
- Fix a typo [\#147](https://github.com/johnbellone/consul-cookbook/pull/147) ([thedebugger](https://github.com/thedebugger))
- Missing \# from string interpolation [\#146](https://github.com/johnbellone/consul-cookbook/pull/146) ([gavinheavyside](https://github.com/gavinheavyside))
- Adds systemd init style \(support for arch platform\) [\#145](https://github.com/johnbellone/consul-cookbook/pull/145) ([logankoester](https://github.com/logankoester))
- Add support for HTTP checks [\#143](https://github.com/johnbellone/consul-cookbook/pull/143) ([gavinheavyside](https://github.com/gavinheavyside))
- Chown service directories recursively. Fixes \#140 [\#141](https://github.com/johnbellone/consul-cookbook/pull/141) ([thedebugger](https://github.com/thedebugger))
- Add 0.5.0 checkums, fixes \#136 [\#138](https://github.com/johnbellone/consul-cookbook/pull/138) ([jhmartin](https://github.com/jhmartin))
- UI path is a directory. Fix \#133 [\#134](https://github.com/johnbellone/consul-cookbook/pull/134) ([thedebugger](https://github.com/thedebugger))
- Force-kill on /etc/init.d/consul stop. Fixes \#128 [\#129](https://github.com/johnbellone/consul-cookbook/pull/129) ([jhmartin](https://github.com/jhmartin))

## [v0.8.3](https://github.com/johnbellone/consul-cookbook/tree/v0.8.3) (2015-02-14)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.8.2...v0.8.3)

**Merged pull requests:**

- Add missing export for GOMAXPROCS [\#132](https://github.com/johnbellone/consul-cookbook/pull/132) ([webcoyote](https://github.com/webcoyote))

## [v0.8.2](https://github.com/johnbellone/consul-cookbook/tree/v0.8.2) (2015-02-11)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.8.1...v0.8.2)

**Closed issues:**

- Kill on incomplete shutdown [\#128](https://github.com/johnbellone/consul-cookbook/issues/128)
- Add support for dnsmasq [\#89](https://github.com/johnbellone/consul-cookbook/issues/89)

**Merged pull requests:**

- Set GOMAXPROCS for runit services [\#130](https://github.com/johnbellone/consul-cookbook/pull/130) ([webcoyote](https://github.com/webcoyote))

## [v0.8.1](https://github.com/johnbellone/consul-cookbook/tree/v0.8.1) (2015-02-06)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.8.0...v0.8.1)

**Merged pull requests:**

- correction to EL init template for active binary and config dir argument... [\#123](https://github.com/johnbellone/consul-cookbook/pull/123) ([paulysullivan](https://github.com/paulysullivan))

## [v0.8.0](https://github.com/johnbellone/consul-cookbook/tree/v0.8.0) (2015-02-06)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.7.1...v0.8.0)

**Closed issues:**

- install\_binary breaks upgrade [\#116](https://github.com/johnbellone/consul-cookbook/issues/116)
- extra\_params doesn't merge [\#111](https://github.com/johnbellone/consul-cookbook/issues/111)

**Merged pull requests:**

- remove unit tests which describe exactly what the code describes [\#122](https://github.com/johnbellone/consul-cookbook/pull/122) ([reset](https://github.com/reset))
- Upgradeable Consul Binary [\#121](https://github.com/johnbellone/consul-cookbook/pull/121) ([reset](https://github.com/reset))
- Fix quoting of bootstrap\_expect in README [\#112](https://github.com/johnbellone/consul-cookbook/pull/112) ([jhmartin](https://github.com/jhmartin))
- Make upstart script respawn consul on crash [\#108](https://github.com/johnbellone/consul-cookbook/pull/108) ([tgwizard](https://github.com/tgwizard))

## [v0.7.1](https://github.com/johnbellone/consul-cookbook/tree/v0.7.1) (2015-01-24)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.7.0...v0.7.1)

**Merged pull requests:**

- Support consul reload when using runit [\#110](https://github.com/johnbellone/consul-cookbook/pull/110) ([webcoyote](https://github.com/webcoyote))

## [v0.7.0](https://github.com/johnbellone/consul-cookbook/tree/v0.7.0) (2015-01-23)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.6.0...v0.7.0)

**Implemented enhancements:**

- Create a new provider "check\_def" [\#66](https://github.com/johnbellone/consul-cookbook/issues/66)
- Implementing bootstrap-expect [\#31](https://github.com/johnbellone/consul-cookbook/issues/31)

**Fixed bugs:**

- Should check\_def create the file using the id property instead of name? [\#99](https://github.com/johnbellone/consul-cookbook/issues/99)
- Install from source fails integration tests [\#41](https://github.com/johnbellone/consul-cookbook/issues/41)

**Closed issues:**

- Every NEW node will fail at first chef-client [\#97](https://github.com/johnbellone/consul-cookbook/issues/97)
- Allow to use retry\_join instead of start\_join [\#93](https://github.com/johnbellone/consul-cookbook/issues/93)

**Merged pull requests:**

- Update README.md [\#109](https://github.com/johnbellone/consul-cookbook/pull/109) ([tupy](https://github.com/tupy))
- Fixup a cell in README [\#105](https://github.com/johnbellone/consul-cookbook/pull/105) ([thorduri](https://github.com/thorduri))
- Add Service Watch LWRP [\#103](https://github.com/johnbellone/consul-cookbook/pull/103) ([monkeylittle](https://github.com/monkeylittle))
- Let user decide join strategy on cluster mode [\#102](https://github.com/johnbellone/consul-cookbook/pull/102) ([inean](https://github.com/inean))
- making it work with golang cookbook 1.4.0 [\#101](https://github.com/johnbellone/consul-cookbook/pull/101) ([opsline-radek](https://github.com/opsline-radek))
- Prefer id over name consul check filename [\#100](https://github.com/johnbellone/consul-cookbook/pull/100) ([tgwizard](https://github.com/tgwizard))
- Allow custom data bag and data bag item for consul encrypt [\#98](https://github.com/johnbellone/consul-cookbook/pull/98) ([inean](https://github.com/inean))
- Add some additional options to the service\_config hash. [\#90](https://github.com/johnbellone/consul-cookbook/pull/90) ([darron](https://github.com/darron))
- WIP: LISA conference hacking [\#88](https://github.com/johnbellone/consul-cookbook/pull/88) ([johnbellone](https://github.com/johnbellone))

## [v0.6.0](https://github.com/johnbellone/consul-cookbook/tree/v0.6.0) (2014-12-11)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/0.5.1...v0.6.0)

**Implemented enhancements:**

- Add attributes to configure Consul ports [\#26](https://github.com/johnbellone/consul-cookbook/pull/26) ([jubianchi](https://github.com/jubianchi))

**Closed issues:**

- Interest in Key/Value LWRP [\#77](https://github.com/johnbellone/consul-cookbook/issues/77)
- /etc/sysconfig does not exist on Ubuntu 14.04 [\#63](https://github.com/johnbellone/consul-cookbook/issues/63)
- Write HOWTO [\#49](https://github.com/johnbellone/consul-cookbook/issues/49)

**Merged pull requests:**

- {1..10} does not work in sh [\#95](https://github.com/johnbellone/consul-cookbook/pull/95) ([opsline-radek](https://github.com/opsline-radek))
- made a mistake in formatting the json file for the watches [\#94](https://github.com/johnbellone/consul-cookbook/pull/94) ([ericfode](https://github.com/ericfode))
- Update matchers.rb [\#87](https://github.com/johnbellone/consul-cookbook/pull/87) ([ericfode](https://github.com/ericfode))
- Update README.md [\#86](https://github.com/johnbellone/consul-cookbook/pull/86) ([ericfode](https://github.com/ericfode))
- extra params using node object as base [\#85](https://github.com/johnbellone/consul-cookbook/pull/85) ([ericfode](https://github.com/ericfode))
- Key watch [\#84](https://github.com/johnbellone/consul-cookbook/pull/84) ([ericfode](https://github.com/ericfode))
- Event watch [\#82](https://github.com/johnbellone/consul-cookbook/pull/82) ([ericfode](https://github.com/ericfode))
- add upstart init [\#71](https://github.com/johnbellone/consul-cookbook/pull/71) ([wilreichert](https://github.com/wilreichert))

## [0.5.1](https://github.com/johnbellone/consul-cookbook/tree/0.5.1) (2014-11-06)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/0.4.3...0.5.1)

**Implemented enhancements:**

- GOMAXPROCS picks number of CPUs using sysconfig - Also updated Serverspec to 2.0 [\#52](https://github.com/johnbellone/consul-cookbook/pull/52) ([goncalopereira](https://github.com/goncalopereira))

**Closed issues:**

-  The service consul is not present and restart fail [\#76](https://github.com/johnbellone/consul-cookbook/issues/76)
- Doesn't restart on configuration change [\#72](https://github.com/johnbellone/consul-cookbook/issues/72)
- Stop Consul With SIGINT [\#47](https://github.com/johnbellone/consul-cookbook/issues/47)
- Create consul\_directories in install\_\* recipes [\#40](https://github.com/johnbellone/consul-cookbook/issues/40)

**Merged pull requests:**

- Fixes \#76 [\#81](https://github.com/johnbellone/consul-cookbook/pull/81) ([thedebugger](https://github.com/thedebugger))
- Update README.md with basic getting started [\#79](https://github.com/johnbellone/consul-cookbook/pull/79) ([ericfode](https://github.com/ericfode))
- fixes \#72.  [\#75](https://github.com/johnbellone/consul-cookbook/pull/75) ([dpetzel](https://github.com/dpetzel))
- Update last action so that notifications can work [\#74](https://github.com/johnbellone/consul-cookbook/pull/74) ([thedebugger](https://github.com/thedebugger))
- Send reload singal to consul on a service\_def change [\#70](https://github.com/johnbellone/consul-cookbook/pull/70) ([thedebugger](https://github.com/thedebugger))
- update consul ui test [\#69](https://github.com/johnbellone/consul-cookbook/pull/69) ([kevinreedy](https://github.com/kevinreedy))
- set correct etc config directory for default consul behavior [\#68](https://github.com/johnbellone/consul-cookbook/pull/68) ([wilreichert](https://github.com/wilreichert))
- Added consul-check-def provider [\#67](https://github.com/johnbellone/consul-cookbook/pull/67) ([lyrixx](https://github.com/lyrixx))
- Fixed default version installed in README.md [\#64](https://github.com/johnbellone/consul-cookbook/pull/64) ([lyrixx](https://github.com/lyrixx))
- Use id \(if present\) in the service def file path [\#62](https://github.com/johnbellone/consul-cookbook/pull/62) ([thedebugger](https://github.com/thedebugger))
- Consul 0.4.1 [\#61](https://github.com/johnbellone/consul-cookbook/pull/61) ([rnaveiras](https://github.com/rnaveiras))
- Updated unkown `service\_mode` error message [\#60](https://github.com/johnbellone/consul-cookbook/pull/60) ([kppullin](https://github.com/kppullin))
- Add encrypt to README [\#57](https://github.com/johnbellone/consul-cookbook/pull/57) ([benjaminws](https://github.com/benjaminws))
- API updates & Add encrypt param [\#56](https://github.com/johnbellone/consul-cookbook/pull/56) ([benjaminws](https://github.com/benjaminws))
- Automatic bootstrapping for consul cluster of multiple servers with the bootstrap\_expect value greater than one [\#53](https://github.com/johnbellone/consul-cookbook/pull/53) ([lawsonj2019](https://github.com/lawsonj2019))
- Support for sending consul logs to syslog [\#51](https://github.com/johnbellone/consul-cookbook/pull/51) ([jdef](https://github.com/jdef))
- Gracefully Leave Cluster w/ SIGINT [\#48](https://github.com/johnbellone/consul-cookbook/pull/48) ([noazark](https://github.com/noazark))

## [0.4.3](https://github.com/johnbellone/consul-cookbook/tree/0.4.3) (2014-09-19)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.4.3...0.4.3)

## [v0.4.3](https://github.com/johnbellone/consul-cookbook/tree/v0.4.3) (2014-09-19)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.4.2...v0.4.3)

**Closed issues:**

- Publish v0.4.2 [\#45](https://github.com/johnbellone/consul-cookbook/issues/45)
- Installation fails with ERROR: service\[consul\] \(consul::\_service line 112\) had an error: Chef::Exceptions::Service: service\[consul\]: unable to locate the init.d script! [\#33](https://github.com/johnbellone/consul-cookbook/issues/33)
- Add service LWRP example [\#23](https://github.com/johnbellone/consul-cookbook/issues/23)

**Merged pull requests:**

- Delay runit restart on config file change [\#46](https://github.com/johnbellone/consul-cookbook/pull/46) ([webcoyote](https://github.com/webcoyote))

## [v0.4.2](https://github.com/johnbellone/consul-cookbook/tree/v0.4.2) (2014-09-15)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.3.1...v0.4.2)

**Merged pull requests:**

- Correct LWRP examples [\#44](https://github.com/johnbellone/consul-cookbook/pull/44) ([johntdyer](https://github.com/johntdyer))
- Recipe names in readme were wrong [\#43](https://github.com/johnbellone/consul-cookbook/pull/43) ([johntdyer](https://github.com/johntdyer))
- Update for 0.4.0 [\#42](https://github.com/johnbellone/consul-cookbook/pull/42) ([johntdyer](https://github.com/johntdyer))
- fix for \#31 , implements support for bootstrap-expect and now creates the data\_dir [\#39](https://github.com/johnbellone/consul-cookbook/pull/39) ([ravaa](https://github.com/ravaa))
- Fix resource order to suppress error when service start before create default.json. [\#38](https://github.com/johnbellone/consul-cookbook/pull/38) ([Sheile](https://github.com/Sheile))

## [v0.3.1](https://github.com/johnbellone/consul-cookbook/tree/v0.3.1) (2014-08-29)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.3.0...v0.3.1)

**Closed issues:**

- Repoforge dependency [\#30](https://github.com/johnbellone/consul-cookbook/issues/30)
- Ark version [\#28](https://github.com/johnbellone/consul-cookbook/issues/28)

**Merged pull requests:**

- Update \_service.rb [\#36](https://github.com/johnbellone/consul-cookbook/pull/36) ([brandocorp](https://github.com/brandocorp))
- Fix runit initialization on new server [\#35](https://github.com/johnbellone/consul-cookbook/pull/35) ([webcoyote](https://github.com/webcoyote))
- Support binding to named interfaces [\#34](https://github.com/johnbellone/consul-cookbook/pull/34) ([romesh-mccullough](https://github.com/romesh-mccullough))
- Update metadata.rb release ark version [\#29](https://github.com/johnbellone/consul-cookbook/pull/29) ([jhmartin](https://github.com/jhmartin))
- Restart consul service on configuration change [\#27](https://github.com/johnbellone/consul-cookbook/pull/27) ([jubianchi](https://github.com/jubianchi))
- Delay the consul reload when config file changes [\#25](https://github.com/johnbellone/consul-cookbook/pull/25) ([jubianchi](https://github.com/jubianchi))
- Add checksums for Consul 0.3.1 [\#24](https://github.com/johnbellone/consul-cookbook/pull/24) ([jubianchi](https://github.com/jubianchi))
- Chefspec fixes [\#22](https://github.com/johnbellone/consul-cookbook/pull/22) ([jhmartin](https://github.com/jhmartin))
- fixed serverspec failures [\#21](https://github.com/johnbellone/consul-cookbook/pull/21) ([jarosser06](https://github.com/jarosser06))

## [v0.3.0](https://github.com/johnbellone/consul-cookbook/tree/v0.3.0) (2014-07-04)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.2.2...v0.3.0)

**Merged pull requests:**

- add service\_def LWRP [\#20](https://github.com/johnbellone/consul-cookbook/pull/20) ([reset](https://github.com/reset))
- bump binary installed version of consul to 0.3.0 [\#19](https://github.com/johnbellone/consul-cookbook/pull/19) ([reset](https://github.com/reset))
- minor refactorings [\#18](https://github.com/johnbellone/consul-cookbook/pull/18) ([reset](https://github.com/reset))
- Fix service\_group attribute reference in README [\#17](https://github.com/johnbellone/consul-cookbook/pull/17) ([databus23](https://github.com/databus23))
- Add support for runit [\#16](https://github.com/johnbellone/consul-cookbook/pull/16) ([webcoyote](https://github.com/webcoyote))
- support more configuration parameters [\#15](https://github.com/johnbellone/consul-cookbook/pull/15) ([bkw](https://github.com/bkw))
- Reload on changes [\#14](https://github.com/johnbellone/consul-cookbook/pull/14) ([bkw](https://github.com/bkw))
- support reload via init [\#13](https://github.com/johnbellone/consul-cookbook/pull/13) ([bkw](https://github.com/bkw))
- use configfile instead of hardcoding values into init file [\#12](https://github.com/johnbellone/consul-cookbook/pull/12) ([bkw](https://github.com/bkw))
- remove superfluous subdir consol\_ui [\#11](https://github.com/johnbellone/consul-cookbook/pull/11) ([bkw](https://github.com/bkw))
- Remove 0.2 [\#10](https://github.com/johnbellone/consul-cookbook/pull/10) ([bkw](https://github.com/bkw))

## [v0.2.2](https://github.com/johnbellone/consul-cookbook/tree/v0.2.2) (2014-05-31)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.2.0...v0.2.2)

**Fixed bugs:**

- Source installs are broken [\#1](https://github.com/johnbellone/consul-cookbook/issues/1)

**Merged pull requests:**

- -config-dir for service definitions [\#9](https://github.com/johnbellone/consul-cookbook/pull/9) ([gavinheavyside](https://github.com/gavinheavyside))
- Refer to configured install location [\#8](https://github.com/johnbellone/consul-cookbook/pull/8) ([gavinheavyside](https://github.com/gavinheavyside))
- Add consul::ui recipe [\#7](https://github.com/johnbellone/consul-cookbook/pull/7) ([bdotdub](https://github.com/bdotdub))

## [v0.2.0](https://github.com/johnbellone/consul-cookbook/tree/v0.2.0) (2014-05-09)
**Closed issues:**

- Binary installs broken on centos [\#2](https://github.com/johnbellone/consul-cookbook/issues/2)

**Merged pull requests:**

- Fix a wrong attribute definition [\#6](https://github.com/johnbellone/consul-cookbook/pull/6) ([jemiam](https://github.com/jemiam))
- Fix issues with source install [\#5](https://github.com/johnbellone/consul-cookbook/pull/5) ([jemiam](https://github.com/jemiam))
- Add default recipe which installs and starts consul as a service [\#4](https://github.com/johnbellone/consul-cookbook/pull/4) ([kevinreedy](https://github.com/kevinreedy))
- Update README.md [\#3](https://github.com/johnbellone/consul-cookbook/pull/3) ([ijin](https://github.com/ijin))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
