# frozen_string_literal: true

require_relative 'rake_tasks/generators/init'

module WayOfWorking
  module SubCommands
    # This reopens the "way_of_working init" sub command
    class Init
      register(WayOfWorking::RakeTasks::Generators::Init, 'rake_tasks', 'rake_tasks',
               <<~LONGDESC)
                 Description:
                     Installs Way of Working rake tasks into this project

                 Example:
                     way_of_working init rake_tasks

                     This will amend or create:
                         Rakefile
               LONGDESC
    end
  end
end
