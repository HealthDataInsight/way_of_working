# frozen_string_literal: true

require_relative 'contributor_covenant/generators/init'

# If way_of_working-audit-github is used we can add a rule
begin
  require 'way_of_working/audit/github/rules/registry'
  require_relative 'contributor_covenant/github_audit_rule'
rescue LoadError # rubocop:disable Lint/SuppressedException
end

module WayOfWorking
  module CodeOfConduct
    module ContributorCovenant
      class Error < StandardError; end
    end
  end

  module SubCommands
    # This reopens the "way_of_working init" sub command
    class Init
      register(CodeOfConduct::ContributorCovenant::Generators::Init, 'code_of_conduct',
               'code_of_conduct --contact-method [CONTACT METHOD]',
               <<~LONGDESC)
                 Description:
                     This adds the Contributor Covenant v2.1 code of conduct to the project

                 Example:
                     way_of_working init code_of_conduct --contact-method "foo@bar.com"

                     This will create:
                         CODE_OF_CONDUCT.md
               LONGDESC
    end
  end
end
