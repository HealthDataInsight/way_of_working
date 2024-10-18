# frozen_string_literal: true

require 'way_of_working/audit/github/rules/base'

module WayOfWorking
  # Namespace for the "internal" ReadmeBadge rule
  module ReadmeBadge
    # This rule checks for a README and Way of Working badge.
    class GithubAuditRule < ::WayOfWorking::Audit::Github::Rules::Base
      def valid?
        @errors << 'No README' if readme_content.nil?
        @errors << 'No Way of Working README Badge' unless readme_way_of_working_badge?

        @errors.empty? ? :passed : :failed
      end

      private

      def readme_way_of_working_badge?
        readme_content.include?('Way of Working Badge](https://img.shields.io/badge/')
      end
    end

    ::WayOfWorking::Audit::Github::Rules::Registry.register(GithubAuditRule,
                                                            'Project README and Way of Working badge')
  end
end
