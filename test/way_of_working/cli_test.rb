# frozen_string_literal: true

require 'test_helper'
require 'open3'

module WayOfWorking
  # This class tests WayOfWorking::Cli exit statuses
  class CliTest < ActiveSupport::TestCase
    EXE = File.expand_path('../../exe/way_of_working', __dir__)

    test 'unknown top level command exits non-zero without a deprecation warning' do
      assert_fails_cleanly 'unknown_command'
    end

    test 'unknown subcommand command exits non-zero without a deprecation warning' do
      %w[config exec init new].each { |subcommand| assert_fails_cleanly subcommand, 'unknown_command' }
    end

    private

    def assert_fails_cleanly(*args)
      _stdout, stderr, status = Open3.capture3(RbConfig.ruby, '-Ilib', EXE, *args)

      assert_equal 1, status.exitstatus, stderr
      assert_includes stderr, 'Could not find command "unknown_command"'
      refute_includes stderr, 'Deprecation warning'
    end
  end
end
