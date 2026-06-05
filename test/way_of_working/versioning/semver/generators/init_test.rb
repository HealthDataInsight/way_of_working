require 'test_helper'

module WayOfWorking
  module Versioning
    module Semver
      module Generators
        # This class tests the Versioning::Init Thor Group (generator)
        class InitTest < Rails::Generators::TestCase
          tests WayOfWorking::Versioning::Semver::Generators::Init
          destination WayOfWorking.root.join('tmp/generators')
          setup :prepare_destination

          test 'generator runs without errors' do
            assert_nothing_raised do
              run_generator
            end
          end

          test 'files are created and revoked' do
            run_generator

            assert_file 'docs/way_of_working/versioning.md'

            run_generator [], behavior: :revoke

            assert_no_file 'docs/way_of_working/versioning.md'
          end
        end
      end
    end
  end
end
