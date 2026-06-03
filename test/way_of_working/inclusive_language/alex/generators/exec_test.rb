# frozen_string_literal: true

require 'test_helper'

module WayOfWorking
  module InclusiveLanguage
    module Alex
      module Generators
        # This class tests the InclusiveLanguage::Exec Thor Group (generator)
        class ExecTest < Rails::Generators::TestCase
          tests WayOfWorking::InclusiveLanguage::Alex::Generators::Exec
          destination WayOfWorking.root.join('tmp/generators')

          test 'generator runs without errors' do
            generator_class.any_instance.stubs(:run_alex).returns(true)

            assert_nothing_raised do
              run_generator
            end
          end

          test 'generator aborts if linters error' do
            Rainbow.enabled = false

            # alex errors
            generator_class.any_instance.stubs(:run_alex).returns(false)

            stderr = capture(:stderr) do
              assert_raise ::SystemExit do
                run_generator
              end
            end
            assert_equal 'Inclusive language tests failed!', stderr.strip
          end
        end
      end
    end
  end
end
