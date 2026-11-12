# frozen_string_literal: true

require_relative 'contributor_covenant/generators/init'

# Register the GitHub audit rule (the registry is bundled with this gem)
require_relative 'contributor_covenant/github_audit_rule'

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
                     This adds the Contributor Covenant v3 code of conduct to the project

                 Example:
                     way_of_working init code_of_conduct --contact-method "foo@bar.com"

                     This will create:
                         CODE_OF_CONDUCT.md
               LONGDESC
    end
  end
end
