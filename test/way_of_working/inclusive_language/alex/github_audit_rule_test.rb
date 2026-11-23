# frozen_string_literal: true

require 'test_helper'
require 'octokit'
require 'way_of_working/inclusive_language/alex/github_audit_rule'

module WayOfWorking
  module InclusiveLanguage
    module Alex
      # Registration is covered by test/way_of_working/github_audit_rules_test.rb.
      class GithubAuditRuleTest < Minitest::Test
        BADGE = '[![Inclusive Language](https://github.com/org/repo/actions/workflows/inclusive-language.yml/badge.svg)]'

        def test_passes_when_files_match_templates
          rule = audit
          assert_equal :passed, rule.status, rule.errors
        end

        def test_fails_when_a_file_differs_or_is_missing
          rule = audit('.alexrc' => "{}\n", '.alexignore' => nil)

          assert_equal :failed, rule.status
          assert_equal ['.alexignore is missing or does not match the template',
                        '.alexrc is missing or does not match the template'], rule.errors
        end

        private

        def audit(overrides = {})
          client = mock
          GithubAuditRule::SOURCE_FILES.each do |path|
            content = overrides.fetch(path) { File.read(GithubAuditRule.source_root.join(path)) }
            expectation = client.stubs(:contents).with('org/repo', path: path)
            content ? expectation.returns(stub(content: Base64.encode64(content))) : expectation.raises(Octokit::NotFound)
          end
          client.stubs(:readme).returns(stub(content: Base64.encode64(BADGE)))
          GithubAuditRule.new(client, 'rule', stub(full_name: 'org/repo', default_branch: 'main'), nil)
        end
      end
    end
  end
end
