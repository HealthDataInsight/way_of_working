# frozen_string_literal: true

require 'wow_bot/rules/cis_benchmark/base'

module WayOfWorking
  module Github
    # This is the namespace for GitHub rules
    module Rules
      module CisBenchmark
        module SourceCode
          module CodeChanges
            # This rule checks branch protection is enforced on the default branch.
            # Note: This is a pretty weak, because it just requires the presence of
            # a default branch rule, without specifying what it should contain.
            class DefaultBranchProtection < ::WowBot::Rules::CisBenchmark::Base
              def tags
                super << :cis_level1
              end

              def valid?
                unless default_branch_ruleset?
                  @errors << "No default (#{@repo.default_branch}) branch protection"
                end

                @errors.empty? ? :passed : :failed
              end

              def default_branch_ruleset?
                rulesets.any? do |ruleset|
                  ruleset.dig(:conditions, :ref_name, :include).include?('~DEFAULT_BRANCH')
                end
              end
            end
          end
        end
      end

      Registry.register(CisBenchmark::SourceCode::CodeChanges::DefaultBranchProtection,
                        'Default branch protection')
    end
  end
end
