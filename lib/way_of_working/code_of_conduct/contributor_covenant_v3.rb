# frozen_string_literal: true

require_relative 'contributor_covenant_v3/generators/init'

# If way_of_working-audit-github is used, add the rule. The v2.1 rule matches any
# Contributor Covenant version heading, so it is shared rather than duplicated.
begin
  require 'way_of_working/audit/github/rules/registry'
  require_relative 'contributor_covenant/github_audit_rule'
rescue LoadError # rubocop:disable Lint/SuppressedException
end

module WayOfWorking
  module SubCommands
    # This reopens the "way_of_working init" sub command
    class Init
      register(CodeOfConduct::ContributorCovenantV3::Generators::Init, 'code_of_conduct',
               'code_of_conduct --contact-method [CONTACT METHOD]',
               <<~LONGDESC)
                 Description:
                     This adds the Contributor Covenant v3 code of conduct to the project

                 Example:
                     way_of_working init code_of_conduct --contact-method "foo@bar.com"

                     This will create:
                         CODE_OF_CONDUCT.md
               LONGDESC
    end
  end
end
