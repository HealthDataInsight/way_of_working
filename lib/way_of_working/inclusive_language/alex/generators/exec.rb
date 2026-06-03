# frozen_string_literal: true

require 'thor'
require 'rainbow'

module WayOfWorking
  module InclusiveLanguage
    module Alex
      module Generators
        # This generator runs the inclusive language tests
        class Exec < Thor::Group
          argument :path, type: :string, required: false, desc: 'Optional path of the file to test'

          desc 'This runs the inclusive language tests on this project'

          def run_first
            @start_time = Time.now

            say(Rainbow("Limiting tests to #{path}\n").yellow) if path
          end

          def prep_and_run_alex
            command = ['npx', 'alex', '--why']
            # Configure alex to only test a specific file or folder, if defined
            command << path if path

            say(Rainbow("\nRunning alex...").yellow)

            @alex_ok = run_alex(command)
          end

          def run_last
            say(Rainbow("\nTotal time taken: #{(Time.now - @start_time).to_i} seconds").yellow)

            if @alex_ok
              say(Rainbow("\nInclusive language tests succeeded!").green)
            else
              abort(Rainbow("\nInclusive language tests failed!").red)
            end
          end

          private

          def run_alex(arguments)
            system(*arguments)
          end
        end
      end
    end
  end
end
