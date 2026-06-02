# frozen_string_literal: true

require 'thor'

module WayOfWorking
  module InclusiveLanguage
    module Alex
      module Generators
        # This generator adds the alexrc file
        class Init < Thor::Group
          include Thor::Actions

          source_root WayOfWorking.root.join('lib', 'way_of_working', 'inclusive_language', 'alex', 'templates')

          def copy_inclusive_language_github_workflow_action
            copy_file '.github/workflows/inclusive-language.yml'
          end

          def copy_alexignore_file
            copy_file '.alexignore'
          end

          def copy_alexrc_file
            copy_file '.alexrc'
          end

          def copy_way_of_working_documentation
            copy_file 'docs/way_of_working/inclusive-language.md'
          end
        end
      end
    end
  end
end
