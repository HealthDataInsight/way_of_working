# frozen_string_literal: true

require_relative 'keepachangelog/generators/init'

# If way_of_working-audit-github is used we can add a rule
begin
  require 'way_of_working/audit/github/rules/registry'
  require_relative 'keepachangelog/github_audit_rule'
rescue LoadError # rubocop:disable Lint/SuppressedException
end

module WayOfWorking
  module Changelog
    module Keepachangelog
      class Error < StandardError; end
    end
  end

  module SubCommands
    # This reopens the "way_of_working init" sub command
    class Init
      register(Changelog::Keepachangelog::Generators::Init, 'changelog', 'changelog',
               <<~LONGDESC)
                 Description:
                     This adds the Keep a Changelog v1.1 changelog to the project

                 Example:
                     way_of_working init changelog

                     This will create:
                     CHANGELOG.md
               LONGDESC
    end
  end
end
