# frozen_string_literal: true

require 'way_of_working/generators/linter/exec'
require_relative 'base'

module WayOfWorking
  module SubCommands
    # This class defines the exec (i.e. run) parent command
    class Exec < Base
      register(WayOfWorking::Generators::Linter::Exec, 'linter', 'linter',
               <<~LONGDESC)
                 Description:
                     This runs the linter on this project

                 Example:
                     way_of_working exec linter
               LONGDESC
    end
  end
end
