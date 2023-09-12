require 'test_helper'
require 'way_of_working/generators/linter/init'

module WayOfWorking
  module Generators
    module Linter
      # This class tests the Linter::Init Thor Group (generator)
      class InitTest < Rails::Generators::TestCase
        tests WayOfWorking::Generators::Linter::Init
        destination WayOfWorking.root.join('tmp/generators')
        setup :prepare_destination

        test 'generator runs without errors' do
          assert_nothing_raised do
            run_generator
          end
        end

        test 'files are created and revoked' do
          run_generator

          assert_file '.github/linters/rubocop_defaults.yml'
          assert_file '.github/linters/.markdown-link-check.json'
          assert_file '.github/workflows/mega-linter.yml'
          assert_file '.mega-linter.yml'
          assert_file '.rubocop'

          assert_file '.gitignore' do |content|
            assert_match("megalinter-reports/\n", content)
            assert_match(".rubocop-https---*\n", content)
          end

          run_generator [], behavior: :revoke

          assert_no_file '.github/linters/rubocop_defaults.yml'
          assert_no_file '.github/workflows/mega-linter.yml'
          assert_no_file '.mega-linter.yml'
          assert_no_file '.rubocop'

          assert_file '.gitignore' do |content|
            refute_match("megalinter-reports/\n", content)
            refute_match(".rubocop-https---*\n", content)
          end
        end

        test 'swiftlint build phase added to xcode project' do
          prepare_xcode_project

          run_generator

          assert_file 'XcodeApp.xcodeproj/project.pbxproj' do |content|
            assert_match(Init::LINTING_BUILD_PHASE, content)
            assert_match(Init::LINTING_BUILD_PHASE_DETAILS, content)
          end

          run_generator [], behavior: :revoke

          assert_file 'XcodeApp.xcodeproj/project.pbxproj' do |content|
            refute_match(Init::LINTING_BUILD_PHASE, content)
            refute_match(Init::LINTING_BUILD_PHASE_DETAILS, content)
          end
        end

      private

        # This method will copy a vanilla Rakefile into the destination folder
        def prepare_xcode_project
          xcode_project_destination_directory = destination_root.join('XcodeApp.xcodeproj')
          FileUtils.mkdir(xcode_project_destination_directory)
          FileUtils.copy WayOfWorking.root.join('test', 'resources', 'XcodeApp.xcodeproj', 'project.pbxproj'),
                         xcode_project_destination_directory.join('project.pbxproj')
        end
      end
    end
  end
end
