# frozen_string_literal: true

require 'git'

module WayOfWorking
  module Git
    # This convenience class holds a summary of a git tag
    class SummaryTag
      attr_accessor :change_type, :commit_date, :name

      def initialize(name, commit_date)
        @name = name
        @commit_date = commit_date
      end

      # This method returns the tag version as a Gem::Version
      def version
        Gem::Version.new(name.sub(/\Av\.?/, ''))
      end

      # This enables tag summaries to be sorted by commit date
      def <=>(other)
        commit_date <=> other.commit_date
      end
    end
  end
end
