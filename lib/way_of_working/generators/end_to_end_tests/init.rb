# frozen_string_literal: true

require 'way_of_working/generators/app_server/init'
require 'way_of_working/git/repo_reader'
require 'way_of_working/paths'

module WayOfWorking
  module Generators
    module EndToEndTests
      # This class generates the cypress GitHub workflow
      class Init < Thor::Group
        include Thor::Actions

        CYPRESS_WORKFLOW_FILE = '.github/workflows/cypress.yml'

        source_root ::WayOfWorking.source_root

        def create_cypress_github_workflow_action
          case behavior
          when :invoke
            invoke_cypress_github_workflow_action
          when :revoke
            revoke_cypress_github_workflow_action
          end
        end

        private

        def invoke_cypress_github_workflow_action
          copy_file CYPRESS_WORKFLOW_FILE

          invoke Generators::AppServer::Init, [CYPRESS_WORKFLOW_FILE]
        end

        def revoke_cypress_github_workflow_action
          # This is called to allow the AppServer code to do its own revoke
          invoke Generators::AppServer::Init, [CYPRESS_WORKFLOW_FILE]

          # Now delete the workflow file
          path = File.expand_path(CYPRESS_WORKFLOW_FILE, destination_root)

          say_status :remove, relative_to_original_destination_root(path)
          return unless !options[:pretend] && (File.exist?(path) || File.symlink?(path))

          require 'fileutils'
          ::FileUtils.rm_rf(path)
        end
      end
    end
  end
end
