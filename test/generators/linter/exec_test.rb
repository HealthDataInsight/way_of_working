# frozen_string_literal: true

require 'test_helper'
require 'way_of_working/generators/linter/exec'

module WayOfWorking
  module Generators
    module Linter
      # This class tests the Linter::Exec Thor Group (generator)
      class ExecTest < Rails::Generators::TestCase
        tests WayOfWorking::Generators::Linter::Exec
        destination WayOfWorking.root.join('tmp/generators')

        test 'generator runs without errors' do
          generator_class.any_instance.stubs(:run_rubocop).returns(true)
          generator_class.any_instance.stubs(:run_megalinter).returns(true)

          assert_nothing_raised do
            run_generator
          end
        end

        test 'generator aborts if linters error' do
          Rainbow.enabled = false

          # MegaLinter errors
          generator_class.any_instance.stubs(:run_megalinter).returns(false)
          generator_class.any_instance.stubs(:run_rubocop).returns(true)

          stderr = capture(:stderr) do
            assert_raise ::SystemExit do
              run_generator
            end
          end
          assert_equal 'Linter failed!', stderr.strip

          # Rubocop errors
          generator_class.any_instance.stubs(:run_megalinter).returns(true)
          generator_class.any_instance.stubs(:run_rubocop).returns(false)

          stderr = capture(:stderr) do
            assert_raise ::SystemExit do
              run_generator
            end
          end
          assert_equal 'Linter failed!', stderr.strip

          # MegaLinter and Rubocop errors
          generator_class.any_instance.stubs(:run_megalinter).returns(false)
          generator_class.any_instance.stubs(:run_rubocop).returns(false)

          stderr = capture(:stderr) do
            assert_raise ::SystemExit do
              run_generator
            end
          end
          assert_equal 'Linter failed!', stderr.strip
        end

        test 'linters are called in the right way' do
          # TODO: More tests are needed. Ideally to expect different calls to run_rubocop and run_megalinter
        end
      end
    end
  end
end
