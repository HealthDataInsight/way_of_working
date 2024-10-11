# frozen_string_literal: true

require 'wow_bot/rules/base'

module WayOfWorking
  module Github
    # This is the namespace for GitHub rules
    module Rules
      module CisBenchmark
        # This rule checks branch protection is enforced on the default branch.
        class Base < ::WowBot::Rules::Base
          # We are deliberately overiding the default way_of_working tag
          # for CIS Benchmark rules.
          def tags
            [:cis]
          end
        end
      end
    end
  end
end
