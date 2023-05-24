# frozen_string_literal: true

require 'test_helper'
require 'way_of_working/generators/end_to_end_tests/init'

module WayOfWorking
  module Generators
    module EndToEndTests
      # This class tests the EndToEndTests::Init Thor Group (generator)
      class InitTest < Rails::Generators::TestCase
        tests WayOfWorking::Generators::EndToEndTests::Init
        destination WayOfWorking.root.join('tmp/generators')

        setup do
          prepare_destination

          Init.any_instance.stubs(:url).
            returns('https://github.com/HealthDataInsight/way_of_working')
        end

        test 'generator runs without errors' do
          stub_out_install_cypress_npm_package

          assert_nothing_raised do
            run_generator
          end
        end

        test 'install_cypress_npm_package with npm' do
          stub_out_install_cypress_npm_package

          run_generator
        end

        test 'install_cypress_npm_package with yarn' do
          generator_class.any_instance.expects(:install_node).returns(nil)
          generator_class.any_instance.expects(:node_package_manager).returns(:yarn)
          ::Object.any_instance.stubs(:system).with('yarn add --dev cypress').returns(true)

          run_generator
        end

        test 'Gemfile is updated if it exists' do
          stub_out_install_cypress_npm_package

          prepare_gemfile 'vanilla_rails_Gemfile'

          assert_file 'Gemfile' do |content|
            assert_no_match('gem "cypress-rails"', content)
          end

          run_generator

          assert_file 'Gemfile' do |content|
            assert_match('gem "cypress-rails"', content)
          end
        end

        test 'Gemfile is not created if it is missing' do
          stub_out_install_cypress_npm_package

          assert_no_file 'Gemfile'

          run_generator

          assert_no_file 'Gemfile'
        end

        test 'workflows are created and revoked with rails and no database' do
          prepare_gemfile 'vanilla_rails_Gemfile'
          stub_out_install_cypress_npm_package
          WayOfWorking::Generators::AppServer::Rails.any_instance.stubs(:database_configured?).returns(false)

          run_generator

          assert_file Init::CYPRESS_WORKFLOW_FILE do |content|
            assert_match('RAILS_ENV: test', content)
            assert_no_match('POSTGRES_DB: rails_test', content)
          end
          assert_no_file WayOfWorking::Generators::AppServer::Rails::CI_DATABASE_CONFIG_FILE

          run_generator [], behavior: :revoke

          assert_no_file Init::CYPRESS_WORKFLOW_FILE
          assert_no_file WayOfWorking::Generators::AppServer::Rails::CI_DATABASE_CONFIG_FILE
        end

        test 'workflows are created and revoked with rails and database' do
          prepare_gemfile 'vanilla_rails_Gemfile'
          stub_out_install_cypress_npm_package
          WayOfWorking::Generators::AppServer::Rails.any_instance.stubs(:database_configured?).returns(true)

          run_generator

          assert_file Init::CYPRESS_WORKFLOW_FILE do |content|
            assert_match('RAILS_ENV: test', content)
            assert_match('POSTGRES_DB: rails_test', content)
          end
          assert_file WayOfWorking::Generators::AppServer::Rails::CI_DATABASE_CONFIG_FILE

          run_generator [], behavior: :revoke

          assert_no_file Init::CYPRESS_WORKFLOW_FILE
          assert_no_file WayOfWorking::Generators::AppServer::Rails::CI_DATABASE_CONFIG_FILE
        end

        test 'config initializer not copied without rails' do
        end

        test 'config initializer copied with rails' do
        end

        test 'run_bundle_install' do
          # ???
        end

        test 'gitignore changes are created and revoked' do
          run_generator

          # assert_file '.gitignore' do |content|
          #   assert_match("node_modules/\n", content)
          # end

          run_generator [], behavior: :revoke

          assert_file '.gitignore' do |content|
            refute_match("node_modules/\n", content)
          end
        end

        private

        def stub_out_install_cypress_npm_package
          generator_class.any_instance.expects(:install_node).returns(nil)
          generator_class.any_instance.expects(:node_package_manager).returns(:npm)
          ::Object.any_instance.stubs(:system).with('npm install cypress --save-dev').returns(true)
        end

        # This method will copy a vanilla Rakefile into the destination folder
        def prepare_gemfile(filename)
          copy WayOfWorking.root.join('test', 'resources', filename),
               destination_root.join('Gemfile')
        end
      end
    end
  end
end
