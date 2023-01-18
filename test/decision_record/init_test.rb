require 'test_helper'
require 'way_of_working/decision_record/init'

module WayOfWorking
  module DecisionRecord
    # This class tests the DecisionRecord::Init Thor Group (generator)
    class InitTest < Rails::Generators::TestCase
      tests WayOfWorking::DecisionRecord::Init
      destination WayOfWorking.root.join('tmp/generators')
      setup :prepare_destination

      test 'generator runs without errors' do
        assert_nothing_raised do
          run_generator
        end
      end

      test 'files are created and revoked' do
        run_generator

        assert_file 'docs/decisions/README.md' do |content|
          assert_match('This directory contains decision records for the project', content)
        end
        assert_file 'docs/decisions/adr-template.md' do |content|
          assert_match('date: {YYYY-MM-DD when the decision was last updated}', content)
        end
        assert_file 'docs/decisions/0000-use-markdown-any-decision-records.md'

        run_generator [], behavior: :revoke

        assert_no_file 'docs/decisions/README.md'
        assert_no_file 'docs/decisions/adr-template.md'
        assert_no_file 'docs/decisions/0000-use-markdown-any-decision-records.md'
      end
    end
  end
end
