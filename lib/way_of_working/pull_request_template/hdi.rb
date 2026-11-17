# frozen_string_literal: true

require_relative 'hdi/generators/init'

# Register the GitHub audit rule (the registry is bundled with this gem)
require_relative 'hdi/github_audit_rule'

module WayOfWorking
  module PullRequestTemplate
    module Hdi
      class Error < StandardError; end
    end
  end

  module SubCommands
    # This reopens the "way_of_working init" sub command
    class Init
      register(PullRequestTemplate::Hdi::Generators::Init, 'pull_request_template', 'pull_request_template',
               <<~LONGDESC)
                 Description:
                     Installs the Pull Request template into the project

                 Example:
                     way_of_working init pull_request_template

                     This will create:
                         .github/pull_request_template.md
               LONGDESC
    end
  end
end
