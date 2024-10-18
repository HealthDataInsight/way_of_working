# frozen_string_literal: true

require 'thor'
require 'way_of_working/readme_badge/paths'

module WayOfWorking
  module ReadmeBadge
    module Generators
      HOLDER_END_TAG = "<!-- Way of Working: Badge Holder End -->\n"

      # This generator adds the alexrc file
      class Init < Thor::Group
        include Thor::Actions

        source_root ::WayOfWorking::ReadmeBadge.source_root

        def create_template_readme_if_missing
          template_if_missing 'README.md'
        end

        def insert_badge_holder_into_readme
          content = <<~MARKDOWN + HOLDER_END_TAG

            <!-- Way of Working: Main Badge Holder Start -->
            #{main_badge}
            <!-- Way of Working: Additional Badge Holder Start -->
          MARKDOWN

          insert_into_file 'README.md', content, after: /^#\s.*?\n/
        end

        def copy_way_of_working_documentation
          template 'docs/way_of_working/readme-badges.md'
        end

        private

        def main_badge
          shield_url = 'https://img.shields.io/badge/' \
                       "#{WayOfWorking::Configuration.main_badge_name.gsub(' ', '_')}-" \
                       "v#{WayOfWorking::Configuration.main_badge_version}-%238169e3?labelColor=black"
          "![#{WayOfWorking::Configuration.main_badge_name} Badge](#{shield_url})"
        end

        def template_if_missing(path)
          destination_path = File.join(destination_root, path)
          return if behavior == :revoke || File.exist?(destination_path)

          template(path)
        end
      end
    end
  end
end
