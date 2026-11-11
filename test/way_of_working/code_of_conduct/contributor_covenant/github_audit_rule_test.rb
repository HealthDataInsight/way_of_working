# frozen_string_literal: true

require 'test_helper'
require 'way_of_working/code_of_conduct/contributor_covenant/github_audit_rule'

module WayOfWorking
  module CodeOfConduct
    module ContributorCovenant
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

      # Kept separate from the registration test above, whose teardown unregisters the rule.
      class GithubAuditRuleValidationTest < Minitest::Test
        def test_accepts_v3_headings_only
          assert_equal :failed, audit_status('# Contributor Covenant Code of Conduct')
          assert_equal :passed, audit_status('# Contributor Covenant 3.0 Code of Conduct')
          assert_equal :failed, audit_status('# Some Other Code of Conduct')
        end

        private

        def audit_status(heading)
          client = mock
          client.stubs(:contents).returns(stub(content: Base64.encode64("#{heading}\n\nText\n")))
          GithubAuditRule.new(client, 'rule', stub(full_name: 'org/repo'), nil).status
        end
      end
    end
  end
end
