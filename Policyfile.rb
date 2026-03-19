# frozen_string_literal: true

name 'consul'
default_source :supermarket
cookbook 'consul', path: '.'
cookbook 'test', path: 'test/cookbooks/test'
run_list 'test::default'
named_run_list 'client', 'test::client'
