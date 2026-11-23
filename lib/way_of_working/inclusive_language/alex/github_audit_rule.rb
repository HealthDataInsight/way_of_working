# frozen_string_literal: true

require 'way_of_working/audit/github/rules/base'

module WayOfWorking
  module InclusiveLanguage
    # The namespace for plugin
    module Alex
      # This rule checks the repo has the Inclusive Language files verbatim and the README badge.
      class GithubAuditRule < ::WayOfWorking::Audit::Github::Rules::Base
        SOURCE_FILES = %w[
          .github/workflows/inclusive-language.yml
          .alexignore
          .alexrc
          docs/way_of_working/inclusive-language.md
        ].freeze

        source_root WayOfWorking.root.join('lib', 'way_of_working', 'inclusive_language', 'alex', 'templates')

        def validate
          SOURCE_FILES.each do |path|
            @errors << "#{path} is missing or does not match the template" unless repo_file_contains_source_file?(path)
          end

          @errors << 'Default branch is named "master"' if @repo.default_branch == 'master'

          @errors << 'No Inclusive Language README Badge' unless inclusive_language_badge?
        end

        private

        def inclusive_language_badge?
          readme_content.include?("[![Inclusive Language](https://github.com/#{@repo_name}/actions/workflows/inclusive-language.yml/badge.svg)]")
        end
      end

      ::WayOfWorking::Audit::Github::Rules::Registry.register(
        GithubAuditRule, 'Inclusive Language GitHub Action and README badge'
      )
    end
  end
end
