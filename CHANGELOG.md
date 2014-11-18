# 0.5.0
* Add support for TLS, and gossip encryption

# 0.4.4
* Adds server list to a consul instance running as a cluster with a `bootstrap_expect` value greater than one.

# 0.4.3
* Fix race condition when installing Consul as a runit service
* Documentation fixes

# 0.4.2
Bumps default version of Consul to 0.4.0

# 0.4.1
Bumps default version of Consul to 0.3.1.

Adds support to bind to the IP of a named interface.
- bind_interface, advertise_interface, client_interface attributes
  (thanks [@romesh-mccullough][5])

Test/Quality Coverage
- Expands test coverage to the `consul::ui` and `consul::_service` recipes.
- Passes some more [rubocop][6] and [foodcritic][4] code quality tests.
- Only test in Travis against rubies of future past.

# 0.4.0
Adds [ChefSpec][3] tests and software lint/metrics.

Breaking Changes
- Renames *binary_install* recipe to *install_binary*
- Renames *source_install* recipe to *source_binary*

# 0.3.0
Bumps the release of [Consul][1] to 0.3.0.

Adds Service LWRP (thanks [@reset][2]!)

# 0.2.0
Bumps the release of [Consul][1] to 0.2.0.

Adds `consul::service` recipe.
Adds more tests.

Bug Smashing
- Source installation now works properly.
- Test Kitchen shows all green!

# 0.1.0
Initial release of [Consul][1] cookbook.

Source and binary installation recipes.

[1]: http://consul.io
[2]: https://github.com/reset
[3]: https://github.com/sethvargo/chefspec
[4]: http://acrmp.github.io/foodcritic/
[5]: https://github.com/romesh-mccullough
[6]: https://github.com/bbatsov/rubocop
