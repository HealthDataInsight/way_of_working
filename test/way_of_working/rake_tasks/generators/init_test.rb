# frozen_string_literal: true

require 'test_helper'

module WayOfWorking
  module RakeTasks
    module Generators
      # This class tests the RakeTasks::Init Thor Group (generator)
      class InitTest < Rails::Generators::TestCase
        tests WayOfWorking::RakeTasks::Generators::Init
        destination WayOfWorking.root.join('tmp/generators')
        setup :prepare_destination

        test 'generator runs without errors' do
          assert_nothing_raised do
            prepare_rakefile 'vanilla_rails_Rakefile'

            run_generator
          end
        end

        test 'Rails Rakefile is amended and revoked' do
          prepare_rakefile 'vanilla_rails_Rakefile'

          assert_file 'Rakefile' do |content|
            refute_match("require 'way_of_working/tasks' if Rails.env.development? || Rails.env.test?\n", content)
          end

          run_generator

          assert_file 'Rakefile' do |content|
            assert_match("require 'way_of_working/tasks' if Rails.env.development? || Rails.env.test?\n", content)
          end

          run_generator [], behavior: :revoke

          assert_file 'Rakefile' do |content|
            refute_match("require 'way_of_working/tasks' if Rails.env.development? || Rails.env.test?\n", content)
          end
        end

        test 'Rubocopped Rails Rakefile is amended' do
          # A rubocopped filename must be (lower) snake case
          prepare_rakefile 'rubocopped_vanilla_rails_rakefile'

          assert_file 'Rakefile' do |content|
            refute_match("require 'way_of_working/tasks' if Rails.env.development? || Rails.env.test?\n", content)
          end

          run_generator

          assert_file 'Rakefile' do |content|
            assert_match("require 'way_of_working/tasks' if Rails.env.development? || Rails.env.test?\n", content)
          end
        end

        test 'Bundler Rakefile is amended and revoked' do
          prepare_rakefile 'vanilla_bundler_Rakefile'

          assert_file 'Rakefile' do |content|
            refute_match("require 'way_of_working/tasks'\n", content)
          end

          run_generator

          assert_file 'Rakefile' do |content|
            assert_match("require 'way_of_working/tasks'\n", content)
          end

          run_generator [], behavior: :revoke

          assert_file 'Rakefile' do |content|
            refute_match("require 'way_of_working/tasks'\n", content)
          end
        end

        test 'Rubocopped Bundler Rakefile is amended' do
          # A rubocopped filename must be (lower) snake case
          prepare_rakefile 'rubocopped_vanilla_bundler_rakefile'

          assert_file 'Rakefile' do |content|
            refute_match("require 'way_of_working/tasks'\n", content)
          end

          run_generator

          assert_file 'Rakefile' do |content|
            assert_match("require 'way_of_working/tasks'\n", content)
          end
        end

        test 'Empty Rakefile is amended and revoked' do
          prepare_rakefile 'empty_Rakefile'

          assert_file 'Rakefile' do |content|
            refute_match("require 'way_of_working/tasks'\n", content)
          end

          run_generator

          assert_file 'Rakefile' do |content|
            assert_match("require 'way_of_working/tasks'\n", content)
          end

          run_generator [], behavior: :revoke

          assert_file 'Rakefile' do |content|
            refute_match("require 'way_of_working/tasks'\n", content)
          end
        end

        test 'Missing Rakefile is created' do
          assert_no_file 'Rakefile'

          run_generator

          assert_file 'Rakefile' do |content|
            assert_match("require 'way_of_working/tasks'\n", content)
          end

          run_generator [], behavior: :revoke

          assert_file 'Rakefile' do |content|
            refute_match("require 'way_of_working/tasks'\n", content)
          end
        end

        private

        # This method will copy a vanilla Rakefile into the destination folder
        def prepare_rakefile(filename)
          FileUtils.copy WayOfWorking.root.join('test', 'resources', filename),
                         destination_root.join('Rakefile')
        end
      end
    end
  end
end
