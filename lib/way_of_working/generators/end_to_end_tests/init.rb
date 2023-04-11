# frozen_string_literal: true

require 'active_support/core_ext/array/extract_options'
require 'rails/generators/actions'
require 'yaml'

require 'way_of_working/generators/app_server/init'
require 'way_of_working/generators/helpers/node'
require 'way_of_working/generators/helpers/shell'
require 'way_of_working/git/repo_reader'
require 'way_of_working/paths'

module WayOfWorking
  module Generators
    module EndToEndTests
      # This class generates the cypress GitHub workflow
      class Init < Thor::Group
        include Thor::Actions
        include WayOfWorking::Generators::Helpers::Node
        include WayOfWorking::Generators::Helpers::Shell
        include ::Rails::Generators::Actions

        CYPRESS_WORKFLOW_FILE = '.github/workflows/cypress.yml'

        source_root ::WayOfWorking.source_root

        def install_cypress_npm_package
          return unless behavior == :invoke

          install_node

          if node_package_manager == :yarn
            # TODO: Check if yarn installed already?
            system('yarn add --dev cypress')
          else
            # TODO: Check if node installed already?
            system('npm install cypress --save-dev')
          end
        end

        def add_gem_to_gemfile
          return unless rails_app?

          gem_group :development, :test do
            gem 'cypress-rails'
          end
        end

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
