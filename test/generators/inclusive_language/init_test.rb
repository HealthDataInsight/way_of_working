require 'test_helper'
require 'way_of_working/generators/inclusive_language/init'

module WayOfWorking
  module Generators
    module InclusiveLanguage
      # This class tests the InclusiveLanguage::Init generator
      class InitTest < Rails::Generators::TestCase
        tests WayOfWorking::Generators::InclusiveLanguage::Init
        destination WayOfWorking.root.join('tmp/generators')
        setup :prepare_destination

        test 'generator runs without errors' do
          assert_nothing_raised do
            run_generator
          end
        end

        test 'file is created and revoked' do
          run_generator

          assert_file '.alexrc'

          run_generator [], behavior: :revoke

          assert_no_file '.alexrc'
        end
      end
    end
  end
end
