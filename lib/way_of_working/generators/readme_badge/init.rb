# frozen_string_literal: true

require 'thor'
require 'way_of_working/paths'

module WayOfWorking
  module Generators
    module ReadmeBadge
      HOLDER_END_TAG = "<!-- HDI Way of Working: Badge Holder End -->\n"

      # This generator adds the alexrc file
      class Init < Thor::Group
        include Thor::Actions

        source_root ::WayOfWorking.source_root

        def create_template_readme_if_missing
          template_if_missing 'README.md'
        end

        def insert_badge_holder_into_readme
          content = <<~MARKDOWN + HOLDER_END_TAG

            <!-- HDI Way of Working: Badge Holder Start -->
            [![HDI Way of Working](https://img.shields.io/badge/HDI-Way%20of%20Working-8169e3?labelColor=000)](https://healthdatainsight.github.io/way_of_working/)
          MARKDOWN

          insert_into_file 'README.md', "#{content}\n", after: /^#\s.*?\n/
        end

        private

        def template_if_missing(path)
          destination_path = File.join(destination_root, path)
          return if behavior == :revoke || File.exist?(destination_path)

          template(path)
        end
      end
    end
  end
end
