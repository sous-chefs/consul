require 'chefspec'
require 'chefspec/berkshelf'
require 'poise_boiler/spec_helper'
require_relative '../../libraries/helpers'
require_relative('support/chefspec_extensions/automatic_resource_matcher')

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
