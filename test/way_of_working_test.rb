# frozen_string_literal: true

require 'test_helper'

# This class provides the most basic of tests
class WayOfWorkingTest < ActiveSupport::TestCase
  test 'it has a version number' do
    refute_nil ::WayOfWorking::VERSION
  end
end
