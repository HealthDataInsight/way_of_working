# frozen_string_literal: true

require 'way_of_working/audit/github/rules/base'

module WayOfWorking
  module Changelog
    # The namespace for this plugin
    module Keepachangelog
      # This rule checks for the Pull Request template.
      class GithubAuditRule < ::WayOfWorking::Audit::Github::Rules::Base
        def validate
          @errors << 'No Keep a Changelog CHANGELOG.md found' unless keep_a_changelog_found?
        end

        private

        def keep_a_changelog_found?
          response = @client.contents(@repo_name, path: 'CHANGELOG.md')
          decoded_content = Base64.decode64(response.content)

          decoded_content.include?('Keep a Changelog')
        rescue Octokit::NotFound
          false
        end
      end

      ::WayOfWorking::Audit::Github::Rules::Registry.register(
        GithubAuditRule, 'Keep a Changelog CHANGELOG.md'
      )
    end
  end
end
