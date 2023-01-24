# frozen_string_literal: true

require 'thor'
require 'rainbow'

module WayOfWorking
  module Generators
    module Linter
      # This generator runs the linter
      class Exec < Thor::Group
        argument :path, type: :string, required: false, desc: 'Optional path of the file to lint'

        desc 'This runs the linter on this project'

        def run_first
          @start_time = Time.now

          say(Rainbow("Limiting linters to #{path}\n").yellow) if path
        end

        # Run RuboCop
        def prep_and_run_rubocop
          puts Rainbow('Running RuboCop...').yellow

          @rubocop_ok = run_rubocop(ARGV[2..])
        end

        # Run MegaLinter
        def prep_and_run_megalinter
          command = ['npx', 'mega-linter-runner', '--remove-container']
          # Configure MegaLinter to only lint a specific file or folder, if defined
          command.prepend("MEGALINTER_FILES_TO_LINT=\"#{path}\"") if path
          # We only want reports created in the working directory
          command.prepend('env', "GITHUB_WORKSPACE=\"#{Dir.pwd}\"")

          puts Rainbow("\nRunning MegaLinter...").yellow

          @megalinter_ok = run_megalinter(command)
        end

        # We run this last to enable all the linters to run first
        def run_last
          puts Rainbow("\nTotal time taken: #{(Time.now - @start_time).to_i} seconds").yellow

          if !@rubocop_ok || !@megalinter_ok
            abort(Rainbow("\nLinter failed!").red)
          else
            say(Rainbow("\nLinter Succeeded!").green)
          end
        end

        private

        def path_directory
          return path if File.directory?(path)

          File.dirname(path)
        end

        def run_rubocop(arguments)
          # We lazy-load RuboCop so that the task doesn't dramatically impact the
          # load time of our commands.
          require 'rubocop'

          cli = RuboCop::CLI.new
          !cli.run(arguments).nonzero?
        end

        def run_megalinter(arguments)
          arguments.prepend('time')

          system(*arguments)
        end
      end
    end
  end
end
