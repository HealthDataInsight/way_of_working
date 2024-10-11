# frozen_string_literal: true

require 'way_of_working/github/rules/base'

module WayOfWorking
  module Github
    module Rules
      # The namespace for WayOfWorking GitHub rules
      module Linter
        # This rule checks for the MegaLinter workflow action and README badge.
        class GithubActionAndBadge < ::WayOfWorking::Github::Rules::Base
          def valid?
            response = @client.workflows(@repo_name)

            unless response.workflows.map(&:name).include?('MegaLinter')
              @errors << 'No MegaLinter GitHub Action'
            end

            @errors << 'No MegaLinter README Badge' unless megalinter_badge?

            @errors.empty? ? :passed : :failed
          end

          private

          def megalinter_badge?
            readme_content.include?("[![MegaLinter](https://github.com/#{@repo_name}/workflows/MegaLinter/badge.svg")
          end
        end

        Registry.register(GithubActionAndBadge, 'MegaLinter GitHub Action and README badge')
      end
    end
  end
end
