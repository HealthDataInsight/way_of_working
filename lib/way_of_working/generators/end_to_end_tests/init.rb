# frozen_string_literal: true

require 'active_support/core_ext/array/extract_options'
require 'rails/generators/actions'
require 'yaml'

require 'way_of_working/generators/app_server/init'
require 'way_of_working/generators/helpers/git'
require 'way_of_working/generators/helpers/node'
require 'way_of_working/generators/helpers/shell'
require 'way_of_working/paths'

module WayOfWorking
  module Generators
    module EndToEndTests
      # This class generates the cypress GitHub workflow
      class Init < Thor::Group
        include Thor::Actions
        include WayOfWorking::Generators::Helpers::Node
        include WayOfWorking::Generators::Helpers::Git
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

        def copy_rails_config_initializer
          return unless rails_app?

          copy_file 'config/initializers/cypress_rails.rb'
        end

        def add_test_badge_to_README
          # way_of_working init readme_badge
          invoke Generators::ReadmeBadge::Init, []

          # [![Cypress](#{url}/actions/workflows/cypress.yml/badge.svg)](#{url}/actions/workflows/cypress.yml)
        end

        def run_bundle_install
          return unless rails_app?

          system('bundle install')
          system('bundle exec rake cypress:init')
        end

        def create_gitignore_if_missing
          create_file_if_missing '.gitignore'
        end

        def gitignore_node_modules_folder
          case behavior
          when :invoke
            append_to_file '.gitignore', "node_modules/\n"
          when :revoke
            # Do nothing
          end
        end

        private

        def create_file_if_missing(path)
          path = File.join(destination_root, path)
          return if behavior == :revoke || File.exist?(path)

          File.open(path, 'w', &:write)
        end

        def invoke_cypress_github_workflow_action
          copy_file CYPRESS_WORKFLOW_FILE

          invoke Generators::AppServer::Init, [CYPRESS_WORKFLOW_FILE]

          # TODO: Add Cypress code to workflow file
        end

        def revoke_cypress_github_workflow_action
          # TODO: Remove Cypress code to workflow file

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
