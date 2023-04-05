require 'test_helper'
require 'way_of_working/generators/decision_record/init'

module WayOfWorking
  module Generators
    module EndToEndTests
      # This class tests the EndToEndTests::Init Thor Group (generator)
      class InitTest < Rails::Generators::TestCase
        tests WayOfWorking::Generators::EndToEndTests::Init
        destination WayOfWorking.root.join('tmp/generators')
        setup :prepare_destination

        test 'generator runs without errors' do
          assert_nothing_raised do
            run_generator
          end
        end

        test 'files are created and revoked with rails and no database' do
          WayOfWorking::Generators::AppServer::Init.any_instance.stubs(:rails_app?).returns(true)
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

        test 'files are created and revoked with rails and database' do
          WayOfWorking::Generators::AppServer::Init.any_instance.stubs(:rails_app?).returns(true)
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
      end
    end
  end
end
