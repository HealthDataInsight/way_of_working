# frozen_string_literal: true

require_relative 'base'

module WayOfWorking
  module Audit
    module Github
      module Rules
        # This is a stub handler for rules that aren't in the registry.
        class Unknown < Base
          def initialize(client, name, repo, rulesets, fix = false)
            super
            raise 'Error: Unknown client'
          end
        end
      end
    end
  end
end
