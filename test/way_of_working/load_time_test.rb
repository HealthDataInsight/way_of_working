# frozen_string_literal: true

require 'open3'
require 'test_helper'

module WayOfWorking
  # Every command (and future shell completion) pays for what `require 'way_of_working'`
  # loads, so the GitHub audit's heavy dependencies must wait until the audit runs.
  # Runs in a fresh process because test_helper already loads all of ActiveSupport.
  class LoadTimeTest < Minitest::Test
    def test_require_does_not_load_audit_dependencies
      script = <<~RUBY
        require 'way_of_working'
        puts [defined?(Octokit).inspect, [].respond_to?(:to_sentence)].join(' ')
      RUBY
      lib_dir = File.expand_path('../../lib', __dir__)
      out, status = Open3.capture2e(RbConfig.ruby, '-I', lib_dir, '-e', script)

      assert status.success?, out
      assert_equal 'nil false', out.lines.last.strip
    end
  end
end
