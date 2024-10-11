# frozen_string_literal: true

require 'way_of_working/github/rules/base'

module WayOfWorking
  module Github
    module Rules
      # The namespace for WayOfWorking GitHub rules
      module WayOfWorking
        # This rule checks for the presence of a README and the Way of Working README badge.
        class ReadmeAndBadge < ::WayOfWorking::Github::Rules::Base
          BADGE_SNIPPET = '[![HDI Way of Working](https://img.shields.io/badge/HDI-Way%20of%20Working'

          def valid?
            if readme_content.blank?
              @errors << 'No README'
            elsif readme_content.exclude?(BADGE_SNIPPET)
              @errors << 'No WoW README Badge'
            end

            @errors.empty? ? :passed : :failed
          end
        end

        Registry.register(ReadmeAndBadge, 'README and WoW badge')
      end
    end
  end
end
