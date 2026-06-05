# frozen_string_literal: true

require 'way_of_working/audit/github/rules/base'

module WayOfWorking
  module PullRequestTemplate
    # The namespace for plugin
    module Hdi
      # This rule checks for the Pull Request template.
      class GithubAuditRule < ::WayOfWorking::Audit::Github::Rules::Base
        def validate
          @errors << 'No Way of Working Pull Request template found' unless pull_request_template?
        end

        private

        def pull_request_template?
          response = @client.contents(@repo_name, path: '.github/pull_request_template.md')
          decoded_content = Base64.decode64(response.content)

          decoded_content.include?('## Screenshots (optional)')
        rescue Octokit::NotFound
          false
        end
      end

      ::WayOfWorking::Audit::Github::Rules::Registry.register(
        GithubAuditRule, 'Pull Request template'
      )
    end
  end
end
