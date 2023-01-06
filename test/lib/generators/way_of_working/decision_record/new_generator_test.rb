require "test_helper"
require "generators/way_of_working/decision_record/new/new_generator"

class WayOfWorking::DecisionRecord::NewGeneratorTest < Rails::Generators::TestCase
  tests WayOfWorking::DecisionRecord::NewGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  FIRST_TITLE = 'New_MARKUP -_Decision-record'
  FIRST_FILENAME = 'docs/decisions/0000-new-markup-decision-record.md'
  SECOND_TITLE = 'Second_ Decision-record'
  SECOND_FILENAME = 'docs/decisions/0001-second-decision-record.md'

  test "generator runs without errors" do
    assert_nothing_raised do
      run_generator [FIRST_TITLE]
    end
  end

  test 'file are created with incrementalnumbers and revoked' do
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
end
