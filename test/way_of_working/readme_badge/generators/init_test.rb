require 'test_helper'

module WayOfWorking
  module ReadmeBadge
    module Generators
      # This class tests the ReadmeBadge::Init Thor Group (generator)
      class InitTest < Rails::Generators::TestCase
        tests WayOfWorking::ReadmeBadge::Generators::Init
        destination WayOfWorking.root.join('tmp/generators')
        setup :prepare_destination

        test 'generator runs without errors' do
          assert_nothing_raised do
            run_generator
          end
        end

        test 'Missing README is created and amended' do
          assert_no_file 'README.md'

          run_generator

          assert_file 'README.md' do |content|
            assert_match("<!-- Way of Working: Main Badge Holder Start -->\n", content)
            assert_match("<!-- Way of Working: Additional Badge Holder Start -->\n", content)
            assert_match("<!-- Way of Working: Badge Holder End -->\n", content)
          end

          run_generator [], behavior: :revoke

          assert_file 'README.md' do |content|
            refute_match("<!-- Way of Working: Main Badge Holder Start -->\n", content)
            refute_match("<!-- Way of Working: Additional Badge Holder Start -->\n", content)
            refute_match("<!-- Way of Working: Badge Holder End -->\n", content)
          end
        end

        test 'Existing README is created and amended' do
          prepare_readme 'test_README.md'

          assert_file 'README.md' do |content|
            refute_match("<!-- Way of Working: Main Badge Holder Start -->\n", content)
            refute_match("<!-- Way of Working: Additional Badge Holder Start -->\n", content)
            refute_match("<!-- Way of Working: Badge Holder End -->\n", content)
          end

          run_generator

          assert_file 'README.md' do |content|
            assert_match("<!-- Way of Working: Main Badge Holder Start -->\n", content)
            assert_match("<!-- Way of Working: Additional Badge Holder Start -->\n", content)
            assert_match("<!-- Way of Working: Badge Holder End -->\n", content)
          end

          run_generator [], behavior: :revoke

          assert_file 'README.md' do |content|
            refute_match("<!-- Way of Working: Main Badge Holder Start -->\n", content)
            refute_match("<!-- Way of Working: Additional Badge Holder Start -->\n", content)
            refute_match("<!-- Way of Working: Badge Holder End -->\n", content)
          end
        end

        test 'Wayof Working documentation is created and revoked' do
          assert_no_file 'docs/way_of_working/readme-badges.md'

          run_generator

          assert_file 'docs/way_of_working/readme-badges.md'

          run_generator [], behavior: :revoke

          assert_no_file 'docs/way_of_working/readme-badges.md'
        end

        private

        # This method will copy a vanilla Rakefile into the destination folder
        def prepare_readme(filename)
          FileUtils.copy WayOfWorking.root.join('test', 'resources', filename),
                         destination_root.join('README.md')
        end
      end
    end
  end
end
