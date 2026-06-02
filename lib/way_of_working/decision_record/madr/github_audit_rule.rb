# frozen_string_literal: true

require 'way_of_working/audit/github/rules/base'

module WayOfWorking
  module DecisionRecord
    # The namespace for plugin
    module Madr
      # This rule checks for the MADR Decision Record template.
      class GithubAuditRule < ::WayOfWorking::Audit::Github::Rules::Base
        ADR_TEMPLATE_PATH = 'docs/decisions/adr-template.md'
        DECISION_ZERO_PATH = 'docs/decisions/0000-use-markdown-any-decision-records.md'
        WOW_DOCUMENTATION_PATH = 'docs/way_of_working/decision-records.md'

        source_root WayOfWorking.root.join('lib', 'way_of_working', 'decision_record', 'madr', 'templates')

        def validate
          @errors << 'No MADR Decision Record template found' unless repo_file_contains?(
            ADR_TEMPLATE_PATH, '## Context and Problem Statement'
          )

          unless repo_file_contains_source_file?(WOW_DOCUMENTATION_PATH)
            @errors << 'Stale or missing documentation for using MADR Decision Records'
          end

          return if repo_file_contains_source_file?(DECISION_ZERO_PATH)

          @errors << 'No 0000-use-markdown-any-decision-records.md Decision Record found'
        end

        private

        def repo_file_contains_source_file?(path)
          repo_file_contains?(path, File.read(self.class.source_root.join(path)))
        end

        def repo_file_contains?(path, text)
          remote_content = repo_file_contents(path)
          return false if remote_content.nil?

          remote_content.include?(text)
        end
      end

      ::WayOfWorking::Audit::Github::Rules::Registry.register(
        GithubAuditRule, 'MADR Decision Records'
      )
    end
  end
end
