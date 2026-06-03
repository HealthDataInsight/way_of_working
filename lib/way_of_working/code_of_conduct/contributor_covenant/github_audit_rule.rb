# frozen_string_literal: true

require 'way_of_working/audit/github/rules/base'

module WayOfWorking
  module CodeOfConduct
    # The namespace for this plugin
    module ContributorCovenant
      # This rule checks for the MegaLinter workflow action and README badge.
      class GithubAuditRule < ::WayOfWorking::Audit::Github::Rules::Base
        def validate
          @errors << 'No Contributor Covenant code of conduct found' unless code_of_conduct?
        end

        private

        def code_of_conduct?
          response = @client.contents(@repo_name, path: 'CODE_OF_CONDUCT.md')
          decoded_content = Base64.decode64(response.content)

          decoded_content.include?('# Contributor Covenant Code of Conduct')
        rescue Octokit::NotFound
          false
        end
      end

      ::WayOfWorking::Audit::Github::Rules::Registry.register(
        GithubAuditRule, 'Contributor Covenant Code Of Conduct'
      )
    end
  end
end
