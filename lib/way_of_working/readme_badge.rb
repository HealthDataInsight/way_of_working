# frozen_string_literal: true

require_relative 'readme_badge/generators/init'

# If way_of_working-audit-github is used we can add a rule
begin
  require 'way_of_working/audit/github/rules/registry'
  require_relative 'readme_badge/github_audit_rule'
rescue LoadError # rubocop:disable Lint/SuppressedException
end

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
