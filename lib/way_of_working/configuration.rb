# frozen_string_literal: true

module WayOfWorking
  # This class stores config information
  class Configuration
    class << self
      attr_writer :organisation_abbreviation, :organisation_gem_version

      def main_badge_name
        [@organisation_abbreviation, 'Way of Working'].compact.join(' ')
      end

      def main_badge_version
        @organisation_gem_version || WayOfWorking::VERSION
      end
    end
  end
end
