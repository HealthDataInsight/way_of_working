# frozen_string_literal: true

require 'test_helper'

module WayOfWorking
  module DecisionRecord
    module Madr
      module Generators
        # This class tests the DecisionRecord::New Thor Group (generator)
        class NewTest < Rails::Generators::TestCase
          tests WayOfWorking::DecisionRecord::Madr::Generators::New
          destination WayOfWorking.root.join('tmp/generators')
          setup :prepare_destination

          FIRST_TITLE = 'New_MARKUP -_Decision-record'
          FIRST_FILENAME = 'docs/decisions/0000-new-markup-decision-record.md'
          SECOND_TITLE = 'Second_ Decision-record'
          SECOND_FILENAME = 'docs/decisions/0001-second-decision-record.md'

          test 'generator runs without errors' do
            assert_nothing_raised do
              run_generator [FIRST_TITLE]
            end
          end

          test 'file are created with incremental numbers and revoked' do
            run_generator [FIRST_TITLE]

            assert_file FIRST_FILENAME do |content|
              assert_match("date: #{Date.today.strftime('%Y-%m-%d')}", content)
            end

            run_generator [SECOND_TITLE]

            assert_file SECOND_FILENAME do |content|
              assert_match("date: #{Date.today.strftime('%Y-%m-%d')}", content)
            end

            run_generator [FIRST_TITLE], behavior: :revoke
            assert_no_file FIRST_FILENAME

            run_generator [SECOND_TITLE], behavior: :revoke
            assert_no_file SECOND_FILENAME
          end

          test 'filename does not contain brackets' do
            run_generator ['Title (Has) Brackets']

            assert_file 'docs/decisions/0000-title-has-brackets.md' do |content|
              assert_match('# Title (Has) Brackets', content)
              assert_match("date: #{Date.today.strftime('%Y-%m-%d')}", content)
            end
          end
        end
      end
    end
  end
end
