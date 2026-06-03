# frozen_string_literal: true

require 'test_helper'

# This module prevents the LoadError when requiring the base class in the GitHub audit rule
module OverrideRequire
  def require(path)
    return if path == 'way_of_working/audit/github/rules/base'

    super
  end
end

module WayOfWorking
  module PullRequestTemplate
    module Hdi
      class GithubAuditRuleTest < Minitest::Test
        # The stub classes define WayOfWorking::Audit purely for this test. Remove it and
        # unload the stub afterwards so each test starts without the registry already defined,
        # regardless of the order the suite runs in.
        def teardown
          WayOfWorking.send(:remove_const, :Audit) if WayOfWorking.const_defined?(:Audit, false)
          $LOADED_FEATURES.reject! { |path| path.end_with?('test/way_of_working/audit_github_stub_classes.rb') }
        end

        def test_the_rule_is_registered
          # Check that the GitHub audit registry is unavailable by default
          refute Object.const_defined?('WayOfWorking::Audit::Github::Rules::Registry')

          require_relative '../../audit_github_stub_classes'

          Kernel.prepend(OverrideRequire)

          # Check that the GitHub audit registry is now available
          assert Object.const_defined?('WayOfWorking::Audit::Github::Rules::Registry')

          require 'way_of_working/pull_request_template/hdi/github_audit_rule'

          assert ::WayOfWorking::Audit::Github::Rules::Registry.rules.values.include?(GithubAuditRule)
          assert_equal [:way_of_working], GithubAuditRule.tags
        end
      end
    end
  end
end
