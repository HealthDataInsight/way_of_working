# frozen_string_literal: true

require 'thor'
require 'way_of_working/git/repo_reader'

module WayOfWorking
  module InclusiveLanguage
    module Alex
      module Generators
        # This generator adds the alexrc file
        class Init < Thor::Group
          BADGE_HOLDER_END_TAG = "<!-- Way of Working: Badge Holder End -->\n"

          include Thor::Actions

          source_root WayOfWorking.root.join('lib', 'way_of_working', 'inclusive_language', 'alex', 'templates')

          def copy_inclusive_language_github_workflow_action
            copy_file '.github/workflows/inclusive-language.yml'
          end

          def copy_alexignore_file
            copy_file '.alexignore'
          end

          def copy_alexrc_file
            copy_file '.alexrc'
          end

          def copy_way_of_working_documentation
            copy_file 'docs/way_of_working/inclusive-language.md'
          end

          # Adds the workflow status badge to the README badge panel created by `init readme_badge`
          def add_badge_to_readme
            readme = File.join(destination_root, 'README.md')
            return unless File.exist?(readme) && File.read(readme).include?(BADGE_HOLDER_END_TAG)
            return unless github_url

            actions_url = "#{github_url}/actions/workflows/inclusive-language.yml"
            insert_into_file 'README.md', "[![Inclusive Language](#{actions_url}/badge.svg)](#{actions_url})\n",
                             before: BADGE_HOLDER_END_TAG
          end

          private

          # Returns e.g. https://github.com/org/repo, or nil if there is no GitHub remote
          def github_url
            remote_url = ::WayOfWorking::Git::RepoReader.new(::Git.open(destination_root)).likely_upstream_remote_url
            repo = remote_url&.match(%r{github\.com[:/]([^/]+/[^/]+?)/?\z})&.[](1)
            "https://github.com/#{repo}" if repo
          rescue ArgumentError
            nil
          end
        end
      end
    end
  end
end
