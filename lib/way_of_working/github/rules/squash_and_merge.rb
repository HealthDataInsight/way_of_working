# frozen_string_literal: true

require_relative 'base'

module WayOfWorking
  module Github
    # This is the namespace for GitHub rules
    module Rules
      # This rule checks for enforced PR squash and merge.
      class SquashAndMerge < Base
        def valid?
          # binding.pry

          @errors.empty?
        end
      end

      Registry.register(SquashAndMerge, 'PR squash and merge')
    end
  end
end
