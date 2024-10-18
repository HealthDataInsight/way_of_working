# frozen_string_literal: true

require 'pathname'

module WayOfWorking
  # Mixin that provides a couple of pathname convenience methods
  module ReadmeBadge
    class << self
      def root
        Pathname.new(File.expand_path('../../..', __dir__))
      end

      def source_root
        root.join('lib', 'way_of_working', 'readme_badge', 'templates')
      end
    end
  end
end
