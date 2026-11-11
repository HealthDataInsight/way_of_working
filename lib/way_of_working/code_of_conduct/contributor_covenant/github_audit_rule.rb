# frozen_string_literal: true

require 'way_of_working/audit/github/rules/base'

module WayOfWorking
  module CodeOfConduct
    # The namespace for this plugin
    module ContributorCovenant
      # This rule checks for a Contributor Covenant code of conduct.
      class GithubAuditRule < ::WayOfWorking::Audit::Github::Rules::Base
        def validate
          @errors << 'No Contributor Covenant code of conduct found' unless code_of_conduct?
        end

        private

        def code_of_conduct?
          response = @client.contents(@repo_name, path: 'CODE_OF_CONDUCT.md')
          decoded_content = Base64.decode64(response.content)

          # Only v3 is accepted; previous versions (e.g. v2.1, headed "Contributor Covenant Code of Conduct") fail
          decoded_content.match?(/^# Contributor Covenant 3(\.\d+)* Code of Conduct$/)
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
