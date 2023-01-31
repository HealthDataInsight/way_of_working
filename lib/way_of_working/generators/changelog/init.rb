# frozen_string_literal: true

require 'way_of_working/paths'
require 'way_of_working/git/repo_reader'

module WayOfWorking
  module Generators
    module Changelog
      # This class fetches the CODE_OF_CONDUCT.md and inserts the contact method
      class Init < Thor::Group
        include Thor::Actions

        source_root ::WayOfWorking.source_root

        HEADER_TEXT = <<~TEXT
          # Changelog

          All notable changes to this project will be documented in this file.

          The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
          and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

        TEXT

        def add_changelog_to_project
          create_file 'CHANGELOG.md' do
            HEADER_TEXT + releases + footer
          end
        end

        private

        def releases
          text = "## [Unreleased]\n\n"
          text += added_change_text(:minor)
          text += deprecated_removed_fixed_security_text(:minor)

          summary_tags.each do |summary_tag|
            text += "## [#{summary_tag.version}] - " \
                    "#{summary_tag.commit_date.strftime('%Y-%m-%d')}\n\n"

            text += added_change_text(summary_tag.change_type)
            text += deprecated_removed_fixed_security_text(summary_tag.change_type)
          end

          text
        end

        def added_change_text(tag_change_type)
          return '' if tag_change_type == :patch

          change_text('Added', 'Detail new feature(s) here', true) +
            change_text('Change', 'Detail change(s) in existing functionality here',
                        tag_change_type == :major)
        end

        def deprecated_removed_fixed_security_text(tag_change_type)
          change_text('Deprecated', 'Detail soon-to-be removed features here') +
            change_text('Removed', 'Detail removed features here', tag_change_type == :major) +
            change_text('Fixed', 'Detail any bug fixes here', true) +
            change_text('Security', 'Detail fixes to vulnerabilities here')
        end

        # This method adds all of the reference style markdown links
        def footer
          return '' if summary_tags.empty?

          previous_tag = nil
          footer_text = ''
          summary_tags.each do |summary_tag|
            footer_text += if previous_tag
                             release_link(summary_tag.name, previous_tag.name, previous_tag.version)
                           else
                             release_link(summary_tag.name, 'HEAD', 'Unreleased')
                           end

            previous_tag = summary_tag
          end

          footer_text += "[#{previous_tag.version}]: #{url}/releases/tag/#{previous_tag.name}\n"

          footer_text
        end

        def release_link(start_tag, end_tag, version)
          "[#{version}]: #{url}/compare/#{start_tag}...#{end_tag}\n"
        end

        def change_text(type, description, likely = false)
          text = "### #{type}\n\n- TODO: #{description}"
          text += ' (if any)' unless likely
          text += "\n\n"
          text
        end

        def repo_reader
          @repo_reader ||= ::WayOfWorking::Git::RepoReader.new(::Git.open('.'))
        end

        def summary_tags
          @summary_tags ||= repo_reader.summary_tags.reverse
        end

        def url
          @url ||= repo_reader.likely_upstream_remote_url
        end
      end
    end
  end
end
