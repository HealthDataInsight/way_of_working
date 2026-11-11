# frozen_string_literal: true

require 'test_helper'
require 'way_of_working/code_of_conduct/contributor_covenant/github_audit_rule'

module WayOfWorking
  module CodeOfConduct
    module ContributorCovenant
      # Registration is covered by test/way_of_working/github_audit_rules_test.rb.
      class GithubAuditRuleTest < Minitest::Test
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
