# frozen_string_literal: true

require 'way_of_working/paths'

module WayOfWorking
  module Generators
    module Linter
      # This generator add the MADR files to the doc/decisions folder
      class Init < Thor::Group
        include Thor::Actions

        source_root ::WayOfWorking.source_root

        def invoke_dependencies
          invoke RakeTasks::Init
        end

        # TODO: copy_rubocop_github_workflow_action

        def copy_github_linters_rubocop_config_file
          copy_file '.github/linters/.rubocop.yml'
        end

        def copy_megalinter_github_workflow_action
          copy_file '.github/workflows/mega-linter.yml'
        end

        def copy_megalinter_dot_file
          copy_file '.mega-linter.yml'
        end

        def create_gitignore_if_missing
          create_file_if_missing '.gitignore'
        end

        def gitignore_reports_folder
          append_to_file '.gitignore', "megalinter-reports/\n"
        end

        def gitignore_rubocop_cached_file
          append_to_file '.gitignore',
                         ".rubocop-https---raw-githubusercontent-com-NHSDigital-ndr-dev-support-v6-1-9-config-rubocop-ndr-yml\n"
        end

        def copy_rubocop_options_file
          copy_file '.rubocop'
        end

        private

        def create_file_if_missing(path)
          path = File.join(destination_root, path)
          return if behavior == :revoke || File.exist?(path)

          File.open(path, 'w', &:write)
        end
      end
    end
  end
end
