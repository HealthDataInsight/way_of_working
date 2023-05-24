require 'test_helper'

module WayOfWorking
  module Generators
    module PrTemplate
      # This class tests the PrTemplate::Init Thor Group (generator)
      class InitTest < Rails::Generators::TestCase
        tests WayOfWorking::Generators::PrTemplate::Init
        destination WayOfWorking.root.join('tmp/generators')
        setup :prepare_destination

        test 'generator runs without errors' do
          assert_nothing_raised do
            run_generator
          end
        end

        test 'files are created and revoked' do
          run_generator

          assert_file '.github/pull_request_template.md'

          run_generator [], behavior: :revoke

          assert_no_file '.github/pull_request_template.md'
        end
      end
    end
  end
end
