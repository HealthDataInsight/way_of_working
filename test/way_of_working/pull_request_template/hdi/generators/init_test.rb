require 'test_helper'

module WayOfWorking
  module PullRequestTemplate
    module Hdi
      module Generators
        # This class tests the PrTemplate::Init Thor Group (generator)
        class InitTest < Rails::Generators::TestCase
          tests WayOfWorking::PullRequestTemplate::Hdi::Generators::Init
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
            assert_file 'docs/way_of_working/pull-request-template-and-guidelines.md'

            run_generator [], behavior: :revoke

            assert_no_file '.github/pull_request_template.md'
            assert_no_file 'docs/way_of_working/pull-request-template-and-guidelines.md'
          end
        end
      end
    end
  end
end
