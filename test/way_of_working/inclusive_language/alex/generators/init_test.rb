require 'test_helper'

module WayOfWorking
  module InclusiveLanguage
    module Alex
      module Generators
        # This class tests the InclusiveLanguage::Init generator
        class InitTest < Rails::Generators::TestCase
          tests WayOfWorking::InclusiveLanguage::Alex::Generators::Init
          destination WayOfWorking.root.join('tmp/generators')
          setup :prepare_destination

          test 'generator runs without errors' do
            assert_nothing_raised do
              run_generator
            end
          end

          test 'file is created and revoked' do
            run_generator

            assert_file '.github/workflows/inclusive-language.yml'
            assert_file '.alexignore'
            assert_file '.alexrc'
            assert_file 'docs/way_of_working/inclusive-language.md'

            run_generator [], behavior: :revoke

            assert_no_file '.github/workflows/inclusive-language.yml'
            assert_no_file '.alexignore'
            assert_no_file '.alexrc'
            assert_no_file 'docs/way_of_working/inclusive-language.md'
          end

          test 'badge is added to the README badge holder and revoked' do
            Init.any_instance.stubs(:github_url).returns('https://github.com/org/repo')
            prepare_readme_with_badge_holder

            run_generator

            badge = '[![Inclusive Language](https://github.com/org/repo/actions/workflows/inclusive-language.yml/badge.svg)]' \
                    '(https://github.com/org/repo/actions/workflows/inclusive-language.yml)'
            assert_file 'README.md', /#{Regexp.escape(badge)}\n<!-- Way of Working: Badge Holder End -->/

            run_generator [], behavior: :revoke

            assert_file('README.md') { |content| refute_includes content, 'Inclusive Language' }
          end

          test 'badge is not added without a GitHub remote' do
            Init.any_instance.stubs(:github_url).returns(nil)
            prepare_readme_with_badge_holder

            run_generator

            assert_file('README.md') { |content| refute_includes content, 'Inclusive Language' }
          end

          test 'README is not created if missing' do
            Init.any_instance.stubs(:github_url).returns('https://github.com/org/repo')

            run_generator

            assert_no_file 'README.md'
          end

          test 'github_url handles https and ssh remotes' do
            generator = Init.new
            {
              'https://github.com/org/repo' => 'https://github.com/org/repo',
              'git@github.com:org/repo' => 'https://github.com/org/repo',
              'https://gitlab.com/org/repo' => nil,
              nil => nil
            }.each do |remote_url, expected|
              ::WayOfWorking::Git::RepoReader.any_instance.stubs(:likely_upstream_remote_url).returns(remote_url)
              ::Git.stubs(:open).returns(nil)

              actual = generator.send(:github_url)
              expected ? assert_equal(expected, actual) : assert_nil(actual)
            end
          end

          private

          def prepare_readme_with_badge_holder
            File.write(destination_root.join('README.md'), <<~MARKDOWN)
              # Project

              <!-- Way of Working: Main Badge Holder Start -->
              <!-- Way of Working: Additional Badge Holder Start -->
              <!-- Way of Working: Badge Holder End -->
            MARKDOWN
          end
        end
      end
    end
  end
end
