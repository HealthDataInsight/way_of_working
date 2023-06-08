require 'test_helper'
require 'way_of_working/generators/linter/document'

module WayOfWorking
  module Generators
    module Linter
      # This class tests the Linter::Init Thor Group (generator)
      class DocumentTest < Rails::Generators::TestCase
        tests WayOfWorking::Generators::Linter::Document
        destination WayOfWorking.root.join('tmp/generators')
        setup :prepare_destination

        test 'generator runs without errors' do
          assert_nothing_raised do
            run_generator
          end
        end

        test 'files are created and revoked' do
          run_generator

          assert_file 'docs/code-linting/linters.md'

          run_generator [], behavior: :revoke

          assert_no_file 'docs/code-linting/linters.md'
        end
      end
    end
  end
end
