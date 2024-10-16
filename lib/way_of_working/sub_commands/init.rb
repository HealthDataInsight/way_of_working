# frozen_string_literal: true

require 'way_of_working/generators/rake_tasks/init'
require 'way_of_working/generators/readme_badge/init'
require_relative 'base'

module WayOfWorking
  module SubCommands
    # This class defines the "init" parent command
    class Init < Base
      desc 'all --contact-method [CONTACT METHOD]',
           'This adds all of the available Way of Working components to this project'
      method_option :contact_method, required: true
      def all
        invoke_all
      end

      register(WayOfWorking::Generators::RakeTasks::Init, 'rake_tasks', 'rake_tasks',
               <<~LONGDESC)
                 Description:
                     Installs Way of Working rake tasks into this project

                 Example:
                     way_of_working init rake_tasks

                     This will amend or create:
                         Rakefile
               LONGDESC

      register(WayOfWorking::Generators::ReadmeBadge::Init, 'readme_badge', 'readme_badge',
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
