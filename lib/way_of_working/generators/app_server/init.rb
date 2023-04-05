# frozen_string_literal: true

require 'way_of_working/generators/app_server/rails'
require 'way_of_working/paths'

module WayOfWorking
  module Generators
    module AppServer
      # This class generates the cypress GitHub workflow
      class Init < Thor::Group
        include Thor::Actions

        argument :file_name, type: :string
        source_root ::WayOfWorking.source_root

        def add_to_workflow
          if rails_app?
            invoke Generators::AppServer::Rails, [file_name]
          else
            say 'Unidentified application type'
          end
        end

        private

        def rails_app?
          File.exist?('Gemfile')
        end
      end
    end
  end
end
