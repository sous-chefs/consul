# 0.4.0
Adds [ChefSpec][3] tests and software lint/metrics.

* Breaking Changes
- Renames *binary_install* recipe to *install_binary*
- Renames *source_install* recipe to *source_binary*

# 0.3.0
Bumps the release of [Consul][1] to 0.3.0

* Additions
  - Service LWRP (thanks [@reset][2]!)

# 0.2.0

Bumps the release of [Consul][1] to 0.2.0

* Bug fixes
  * Source installation now works properly;
  * Test kitchen tests all green;

* Additions
  - More tests!
  - `recipe[consul::service]`

# 0.1.0

Initial release of [Consul][1] cookbook.

* Features
  * Source and binary installation recipes

[1]: http://consul.io
[2]: https://github.com/reset
