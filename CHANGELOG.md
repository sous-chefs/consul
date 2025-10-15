# Changelog

## 5.6.8 - *2025-09-04*

* Standardise files with files in sous-chefs/repo-management

## 5.4.0 - *2022-09-12*

* Add missing `ui_config` attribute to `consul_config`, as `ui` is [deprecated in Consul 1.9.0](https://www.consul.io/docs/agent/config/config-files#ui-parameters)
* Standardise files with files in sous-chefs/repo-management

## 5.3.2 - *2022-02-17*

* Standardise files with files in sous-chefs/repo-management
* Remove delivery folder

## 5.3.1 - *2022-01-04*

* Fix idempotency checks for `consul_token` and `consul_policy`

## 5.3.0 - *2022-01-04*

* Fix wrong number of arguments when calling action `:enable` service on Windows platform

## 5.2.0 - *2021-12-01*

* Added setting `license_path` in `consul_config` resource for enterprise installations

## 5.1.0 - *2021-12-01*

* Support `:stop` action for `consul_service` resource

## 5.0.1 - *2021-11-24*

* Fix setting `program` in `consul_service` resource

## 5.0.0 - *2021-11-22*

* Remove Poise dependencies
* Rewrite resources as Chef custom resources
* Drop compatibility with Chef < 15.3
