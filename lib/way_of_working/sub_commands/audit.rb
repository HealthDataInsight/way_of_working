# frozen_string_literal: true

require_relative 'base'

module WayOfWorking
  module SubCommands
    # This class defines the "way_of_working audit ..." sub command
    class Audit < Base
      register(Generators::Github::Audit, 'github', 'github',
               <<~LONGDESC)
                 Description:
                     This audits github

                 Example:
                     way_of_working audit github
               LONGDESC
    end
  end
end
