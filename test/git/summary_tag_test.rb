# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext'

require 'test_helper'
require 'way_of_working/git/repo_reader'

module WayOfWorking
  module Git
    # This class tests WayOfWorking::Git::SummaryTag
    class SummaryTagTest < ActiveSupport::TestCase
      test 'instance_methods' do
        timestamp = 4.days.ago

        summary_tag = SummaryTag.new('v3.2.1', timestamp)
        summary_tag.change_type = :patch

        assert_equal 'v3.2.1', summary_tag.name
        assert_equal timestamp, summary_tag.commit_date
        assert_equal :patch, summary_tag.change_type

        assert_equal Gem::Version.new('3.2.1'), summary_tag.version

        # Demonstrate that the comparison is based on the commit_date
        assert_equal(1, summary_tag <=> SummaryTag.new('v3.2.1', 5.days.ago))
        assert_equal(0, summary_tag <=> SummaryTag.new('v3.2.1', timestamp))
        assert_equal(-1, summary_tag <=> SummaryTag.new('v3.2.1', 3.days.ago))

        assert_equal(1, timestamp <=> 5.days.ago)
        assert_equal(-1, timestamp <=> 3.days.ago)
      end
    end
  end
end
