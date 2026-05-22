# frozen_string_literal: true

require 'pathname'

module WayOfWorking
  # Namespace for the internal ReadmeBadge plugin
  module ReadmeBadge
    # Mixin that provides a couple of pathname convenience methods
    module Paths
      def root
        Pathname.new(File.expand_path('../../..', __dir__))
      end

      def source_root
        root.join('lib', 'way_of_working', 'readme_badge', 'templates')
      end
    end

    extend Paths
  end
end
