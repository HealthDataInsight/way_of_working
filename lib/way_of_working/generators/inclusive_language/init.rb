# frozen_string_literal: true

require 'thor'
require 'way_of_working/paths'

module WayOfWorking
  module Generators
    module InclusiveLanguage
      # This generator adds the alexrc file
      class Init < Thor::Group
        include Thor::Actions

        source_root ::WayOfWorking.source_root

        def copy_inclusive_language_github_workflow_action
          copy_file '.github/workflows/inclusive-language.yml'
        end

        def copy_alexrc_file
          copy_file '.alexrc'
        end
      end
    end
  end
end
