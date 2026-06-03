# frozen_string_literal: true

require 'way_of_working/audit/github/rules/base'

module WayOfWorking
  module InclusiveLanguage
    # The namespace for plugin
    module Alex
      # This rule checks for the Inclusive Language workflow action and README badge.
      class GithubAuditRule < ::WayOfWorking::Audit::Github::Rules::Base
        def validate
          response = @client.workflows(@repo_name)

          unless response.workflows.map(&:name).include?('Inclusive Language')
            @errors << 'No Inclusive Language GitHub Action'
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
