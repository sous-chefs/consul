# Change Log

## [2.0.0](https://github.com/johnbellone/consul-cookbook/tree/v2.0.0) (2016-03-17)

[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.5.0...HEAD)

**Implemented enhancements:**
- Add the `consul_installation` custom resource for managing archive,
  zip and source installations.
- sysvinit.service.erb has the consul service log to /dev/null [\#284](https://github.com/johnbellone/consul-cookbook/issues/284)
- Refactor the population of TLS files to wrapper cookbooks? [\#247](https://github.com/johnbellone/consul-cookbook/issues/247)

**Closed issues:**

- where does consul installed through this cookbook write its logs  [\#290](https://github.com/johnbellone/consul-cookbook/issues/290)
- Use 'system' attribute when adding consul user & group [\#287](https://github.com/johnbellone/consul-cookbook/issues/287)

## [v1.5.0](https://github.com/johnbellone/consul-cookbook/tree/v1.5.0) (2016-03-07)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.4.3...v1.5.0)

**Closed issues:**

- consul\_acl \(or Diplomat gem\) misbehaving [\#283](https://github.com/johnbellone/consul-cookbook/issues/283)
- Service definition with an integrated check [\#280](https://github.com/johnbellone/consul-cookbook/issues/280)

## [v1.4.3](https://github.com/johnbellone/consul-cookbook/tree/v1.4.3) (2016-02-08)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.4.2...v1.4.3)

## [v1.4.2](https://github.com/johnbellone/consul-cookbook/tree/v1.4.2) (2016-02-08)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.4.1...v1.4.2)

## [v1.4.1](https://github.com/johnbellone/consul-cookbook/tree/v1.4.1) (2016-02-05)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.4.0...v1.4.1)

## [v1.4.0](https://github.com/johnbellone/consul-cookbook/tree/v1.4.0) (2016-02-03)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.3.1...v1.4.0)

**Implemented enhancements:**

- Consul ACL custom resource [\#240](https://github.com/johnbellone/consul-cookbook/issues/240)

**Fixed bugs:**

- libarchive error when installing consul on Ubuntu 14.04 [\#241](https://github.com/johnbellone/consul-cookbook/issues/241)
- Unable to override databag attributes [\#239](https://github.com/johnbellone/consul-cookbook/issues/239)

**Closed issues:**

- retry\_interval should be a string [\#244](https://github.com/johnbellone/consul-cookbook/issues/244)

## [v1.3.1](https://github.com/johnbellone/consul-cookbook/tree/v1.3.1) (2015-10-07)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.3.0...v1.3.1)

## [v1.3.0](https://github.com/johnbellone/consul-cookbook/tree/v1.3.0) (2015-10-07)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.2.0...v1.3.0)

**Implemented enhancements:**

- web UI install missing since 1.0 [\#215](https://github.com/johnbellone/consul-cookbook/issues/215)

## [v1.2.0](https://github.com/johnbellone/consul-cookbook/tree/v1.2.0) (2015-08-24)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.1.1...v1.2.0)

## [v1.1.1](https://github.com/johnbellone/consul-cookbook/tree/v1.1.1) (2015-08-13)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.1.0...v1.1.1)

## [v1.1.0](https://github.com/johnbellone/consul-cookbook/tree/v1.1.0) (2015-08-13)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v1.0.0...v1.1.0)

**Closed issues:**

- Write more comprehensive unit tests. [\#202](https://github.com/johnbellone/consul-cookbook/issues/202)

## [v1.0.0](https://github.com/johnbellone/consul-cookbook/tree/v1.0.0) (2015-08-06)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.11.1...v1.0.0)

**Implemented enhancements:**

- Multiple checks for one service [\#173](https://github.com/johnbellone/consul-cookbook/issues/173)

## [v0.11.1](https://github.com/johnbellone/consul-cookbook/tree/v0.11.1) (2015-07-25)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.11.0...v0.11.1)

## [v0.11.0](https://github.com/johnbellone/consul-cookbook/tree/v0.11.0) (2015-07-23)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.10.1...v0.11.0)

## [v0.10.1](https://github.com/johnbellone/consul-cookbook/tree/v0.10.1) (2015-07-10)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.10...v0.10.1)

**Fixed bugs:**

- Error executing action `extract` on resource 'libarchive\_file\[consul.zip\]' [\#170](https://github.com/johnbellone/consul-cookbook/issues/170)

**Closed issues:**

- Gossip/TLS encryption node attributes still requires consul data\_bag, encrypt item, secret [\#151](https://github.com/johnbellone/consul-cookbook/issues/151)

## [v0.10](https://github.com/johnbellone/consul-cookbook/tree/v0.10) (2015-06-04)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.10.0...v0.10)

## [v0.10.0](https://github.com/johnbellone/consul-cookbook/tree/v0.10.0) (2015-06-04)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.9.1...v0.10.0)

## [v0.9.1](https://github.com/johnbellone/consul-cookbook/tree/v0.9.1) (2015-03-30)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/0.9.0...v0.9.1)

## [0.9.0](https://github.com/johnbellone/consul-cookbook/tree/0.9.0) (2015-03-17)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.8.3...0.9.0)

## [v0.8.3](https://github.com/johnbellone/consul-cookbook/tree/v0.8.3) (2015-02-14)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.8.2...v0.8.3)

## [v0.8.2](https://github.com/johnbellone/consul-cookbook/tree/v0.8.2) (2015-02-11)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.8.1...v0.8.2)

## [v0.8.1](https://github.com/johnbellone/consul-cookbook/tree/v0.8.1) (2015-02-06)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.8.0...v0.8.1)

## [v0.8.0](https://github.com/johnbellone/consul-cookbook/tree/v0.8.0) (2015-02-06)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.7.1...v0.8.0)

## [v0.7.1](https://github.com/johnbellone/consul-cookbook/tree/v0.7.1) (2015-01-24)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.7.0...v0.7.1)

## [v0.7.0](https://github.com/johnbellone/consul-cookbook/tree/v0.7.0) (2015-01-23)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.6.0...v0.7.0)

## [v0.6.0](https://github.com/johnbellone/consul-cookbook/tree/v0.6.0) (2014-12-11)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/0.5.1...v0.6.0)

## [0.5.1](https://github.com/johnbellone/consul-cookbook/tree/0.5.1) (2014-11-06)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/0.4.3...0.5.1)

## [0.4.3](https://github.com/johnbellone/consul-cookbook/tree/0.4.3) (2014-09-19)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.4.3...0.4.3)

## [v0.4.3](https://github.com/johnbellone/consul-cookbook/tree/v0.4.3) (2014-09-19)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.4.2...v0.4.3)

## [v0.4.2](https://github.com/johnbellone/consul-cookbook/tree/v0.4.2) (2014-09-15)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.3.1...v0.4.2)

## [v0.3.1](https://github.com/johnbellone/consul-cookbook/tree/v0.3.1) (2014-08-29)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.3.0...v0.3.1)

## [v0.3.0](https://github.com/johnbellone/consul-cookbook/tree/v0.3.0) (2014-07-04)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.2.2...v0.3.0)

## [v0.2.2](https://github.com/johnbellone/consul-cookbook/tree/v0.2.2) (2014-05-31)
[Full Changelog](https://github.com/johnbellone/consul-cookbook/compare/v0.2.0...v0.2.2)

## [v0.2.0](https://github.com/johnbellone/consul-cookbook/tree/v0.2.0) (2014-05-09)


\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
