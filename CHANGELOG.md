# 0.4.1
Adds support to bind to the IP of a named interface.

* Additions
- bind_interface, advertise_interface, client_interface attributes
  (thanks [@romesh-mccullough][5])

* Test/Quality Coverage
- Expands test coverage to the `consul::ui` recipe.
- Passes [foodcritic][4] lint testing.

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
[3]: https://github.com/sethvargo/chefspec
[4]: http://acrmp.github.io/foodcritic/
[5]: https://github.com/romesh-mccullough
