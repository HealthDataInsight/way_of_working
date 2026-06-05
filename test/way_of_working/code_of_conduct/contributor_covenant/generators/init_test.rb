require 'test_helper'

module WayOfWorking
  module CodeOfConduct
    module ContributorCovenant
      module Generators
        # This class tests the CodeOfConduct::Init Thor Group (generator)
        class InitTest < Rails::Generators::TestCase
          tests WayOfWorking::CodeOfConduct::ContributorCovenant::Generators::Init
          destination WayOfWorking.root.join('tmp/generators')
          setup :prepare_destination

          test 'generator requires contact-method option' do
            stderr = capture(:stderr) do
              run_generator
            end
            assert_match("No value provided for required options '--contact-method'", stderr)

            stderr = capture(:stderr) do
              run_generator %w[--contact-method foo@bar.com]
            end
            refute_match("No value provided for required options '--contact-method'", stderr)
          end

          test 'COC file is created and revoked' do
            code_of_conduct_file = 'CODE_OF_CONDUCT.md'
            run_generator %w[--contact-method foo@bar.com]

            assert_file code_of_conduct_file do |content|
              assert_match('## Our Pledge', content)
              refute_match('[INSERT CONTACT METHOD]', content)
            end
            assert_file 'docs/way_of_working/code-of-conduct.md'

            run_generator %w[--contact-method foo@bar.com], behavior: :revoke

            assert_no_file code_of_conduct_file
            assert_no_file 'docs/way_of_working/code-of-conduct.md'
          end
        end
      end
    end
  end
end
