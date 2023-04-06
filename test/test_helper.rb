# frozen_string_literal: true

# SimpleCov must be required and started before everything else
require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'active_support'
require 'rails/generators/test_case'
require 'way_of_working'

require 'active_support/testing/autorun'

ActiveSupport.test_order = :random if ActiveSupport.respond_to?(:test_order=)

require 'mocha/minitest'
