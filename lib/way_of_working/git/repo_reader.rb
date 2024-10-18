# frozen_string_literal: true

require 'git'
require_relative 'summary_tag'

module WayOfWorking
  module Git
    # This class holds a summary of a git tag
    class RepoReader
      attr_reader :base

      def initialize(base)
        @base = base
      end

      def summary_tags
        tags = @base.tags.map do |tag|
          SummaryTag.new(tag.name, base.gcommit(tag.objectish).date)
        end.sort

        ensure_versions_are_valid_and_increasing!(tags)
        capture_change_types(tags)

        tags
      end

      def likely_upstream_remote_url
        likely_upstream_remote&.url&.sub(/\.git\z/, '')
      end

      private

      def ensure_versions_are_valid_and_increasing!(tags)
        previous_version = nil
        tags.each do |tag|
          next if tag.version.nil?

          raise 'Tag versions are not incremental over time' if previous_version && tag.version <= previous_version

          previous_version = tag.version
        end
      end

      def capture_change_types(tags)
        previous_version_segments = [-1, -1, -1]
        tags.each do |tag|
          tag.change_type = if tag.version.segments[0] > previous_version_segments[0]
                              :major
                            elsif tag.version.segments[1] > previous_version_segments[1]
                              :minor
                            else
                              :patch
                            end

          previous_version_segments = tag.version.segments
        end
      end

      def likely_upstream_remote
        remotes = @base.remotes
        return remotes.first if remotes.count == 1

        remotes = remotes.reject { |remote| remote.name == 'origin' }
        return remotes.first if remotes.count == 1

        remotes.last
      end
    end
  end
end
