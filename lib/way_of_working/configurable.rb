# frozen_string_literal: true

require 'active_support/concern'

module WayOfWorking
  # This is the configurable mixin
  module Configurable
    extend ActiveSupport::Concern

    included do
      module_function

      def organisation_abbreviation=(value)
        @organisation_abbreviation = value
      end

      def organisation_gem_version=(version)
        @organisation_gem_version = version
      end

      def way_of_working_badge_name
        [@organisation_abbreviation, 'Way of Working'].compact.join(' ')
      end

      def way_of_working_badge_version
        @organisation_gem_version || WayOfWorking::VERSION
      end
    end
  end
end
