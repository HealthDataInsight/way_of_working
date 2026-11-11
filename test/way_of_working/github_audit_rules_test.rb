# frozen_string_literal: true

require 'test_helper'

module WayOfWorking
  # Checks each built-in feature's GitHub audit rule registers itself on load.
  class GithubAuditRulesTest < Minitest::Test
    FEATURES = %w[
      changelog/keepachangelog
      code_of_conduct/contributor_covenant
      decision_record/madr
      inclusive_language/alex
      pull_request_template/hdi
      versioning/semver
    ].freeze

    FEATURES.each do |feature|
      define_method("test_#{feature.tr('/', '_')}_rule_is_registered") do
        require "way_of_working/#{feature}/github_audit_rule"
        rule = "WayOfWorking::#{feature.camelize}::GithubAuditRule".constantize

        assert_includes ::WayOfWorking::Audit::Github::Rules::Registry.rules.values, rule
        assert_equal [:way_of_working], rule.tags
      ensure
        # The rules register into a shared registry at load time. Unregister
        # so it doesn't leak between tests, whatever order the suite runs in.
        ::WayOfWorking::Audit::Github::Rules::Registry.rules&.delete_if { |_, klass| klass == rule }
      end
    end
  end
end
