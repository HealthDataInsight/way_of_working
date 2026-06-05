# frozen_string_literal: true

require 'test_helper'
require 'way_of_working/versioning/semver/github_audit_rule'

module WayOfWorking
  module Versioning
    module Semver
      class GithubAuditRuleTest < Minitest::Test
        # The rule registers itself with the (now built-in) GitHub audit registry
        # at load time. Unregister it afterwards so the shared registry doesn't
        # leak between tests, regardless of the order the suite runs in.
        def teardown
          ::WayOfWorking::Audit::Github::Rules::Registry.rules&.delete_if { |_, klass| klass == GithubAuditRule }
        end

        def test_the_rule_is_registered
          assert ::WayOfWorking::Audit::Github::Rules::Registry.rules.values.include?(GithubAuditRule)
          assert_equal [:way_of_working], GithubAuditRule.tags
        end
      end
    end
  end
end
