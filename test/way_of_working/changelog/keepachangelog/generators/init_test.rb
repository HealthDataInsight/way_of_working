# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext'

require 'test_helper'

module WayOfWorking
  module Changelog
    module Keepachangelog
      module Generators
        # This class tests the Changelog::Init Thor Group (generator)
        class InitTest < Rails::Generators::TestCase
          tests WayOfWorking::Changelog::Keepachangelog::Generators::Init
          destination WayOfWorking.root.join('tmp/generators')

          CHANGELOG_FILENAME = 'CHANGELOG.md'

          setup do
            prepare_destination

            Init.any_instance.stubs(:url).
              returns('https://github.com/HealthDataInsight/way_of_working')
          end

          test 'changelog file is created and revoked' do
            Init.any_instance.stubs(:summary_tags).returns([
              ::WayOfWorking::Git::SummaryTag.new('v0.1.0', 10.days.ago),
              ::WayOfWorking::Git::SummaryTag.new('v1.0.0', 7.days.ago),
              ::WayOfWorking::Git::SummaryTag.new('v1.0.1', 6.days.ago),
              ::WayOfWorking::Git::SummaryTag.new('v1.1.0', 4.days.ago),
              ::WayOfWorking::Git::SummaryTag.new('v2.0.0', 1.day.ago)
            ].sort.reverse)

            run_generator

            assert_file CHANGELOG_FILENAME do |content|
              assert_match('# Changelog', content)
              assert_match('## [Unreleased]', content)
              assert_match("## [0.1.0] - #{10.days.ago.strftime('%Y-%m-%d')}", content)
              assert_match("## [2.0.0] - #{1.day.ago.strftime('%Y-%m-%d')}", content)

              assert_match('[Unreleased]: https://github.com/HealthDataInsight/way_of_working/compare/v2.0.0...HEAD', content)
              assert_match('[1.1.0]: https://github.com/HealthDataInsight/way_of_working/compare/v1.0.1...v1.1.0', content)
              assert_match('[1.0.0]: https://github.com/HealthDataInsight/way_of_working/compare/v0.1.0...v1.0.0', content)
            end

            run_generator [], behavior: :revoke

            assert_no_file CHANGELOG_FILENAME
          end

          test 'changelog file is created with no tags' do
            Init.any_instance.stubs(:summary_tags).returns([])

            run_generator

            assert_file CHANGELOG_FILENAME do |content|
              assert_match('# Changelog', content)
              assert_match('## [Unreleased]', content)
            end
            assert_file 'docs/way_of_working/changelog.md'

            run_generator [], behavior: :revoke

            assert_no_file CHANGELOG_FILENAME
            assert_no_file 'docs/way_of_working/changelog.md'
          end
        end
      end
    end
  end
end
