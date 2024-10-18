# frozen_string_literal: true

module WayOfWorking
  module RakeTasks
    module Generators
      # This generator installs way of working rake tasks into this project
      class Init < Thor::Group
        include Thor::Actions

        RAKEFILE_FILENAME = 'Rakefile'
        RAILS_LOC = %r{require_relative ["']config/application["']\n}
        BUNDLER_LOC = %r{require ["']bundler/gem_tasks["']\n}

        def add_to_rakefile
          case rakefile_type
          when :rails
            inject_into_file RAKEFILE_FILENAME,
                             "require 'way_of_working/tasks' if Rails.env.development? " \
                             "|| Rails.env.test?\n",
                             after: RAILS_LOC
          when :bundler
            inject_into_file RAKEFILE_FILENAME,
                             "require 'way_of_working/tasks'\n",
                             after: BUNDLER_LOC
          when :none
            create_file RAKEFILE_FILENAME, "\nrequire 'way_of_working/tasks'\n"
          else
            append_to_file RAKEFILE_FILENAME, "\nrequire 'way_of_working/tasks'\n"
          end
        end

        private

        def rakefile_type
          content = File.read(File.expand_path(RAKEFILE_FILENAME, destination_root))

          return :rails if content.match?(RAILS_LOC)
          return :bundler if content.match?(BUNDLER_LOC)

          :other
        rescue Errno::ENOENT
          :none
        end
      end
    end
  end
end
