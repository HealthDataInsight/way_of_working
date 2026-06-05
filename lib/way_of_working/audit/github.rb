# frozen_string_literal: true

require_relative 'github/generators/exec'

module WayOfWorking
  module Audit
    module Github
      class Error < StandardError; end
    end
  end

  module SubCommands
    # This reopens the "way_of_working exec" sub command
    class Exec
      register(Audit::Github::Generators::Exec, 'audit_github', 'audit_github',
               <<~LONGDESC)
                 Description:
                     This runs the GitHub audit

                 Example:
                     way_of_working exec audit_github
               LONGDESC
    end
  end
end
