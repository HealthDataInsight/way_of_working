# frozen_string_literal: true

require_relative 'readme_badge/generators/init'

require_relative 'readme_badge/github_audit_rule' if WayOfWorking.const_defined?('GithubAudit::Rules::Base')

module WayOfWorking
  module SubCommands
    # This reopens the "way_of_working init" sub command
    class Init
      register(WayOfWorking::ReadmeBadge::Generators::Init, 'readme_badge', 'readme_badge',
               <<~LONGDESC)
                 Description:
                     Installs Way of Working readme badge and badge holder into this project

                 Example:
                     way_of_working init readme_badge

                     This will amend or create:
                         README.md
               LONGDESC
    end
  end
end
