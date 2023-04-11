# frozen_string_literal: true

require 'thor/actions'

module WayOfWorking
  module Generators
    module Helpers
      # File helper methods for generators
      module Shell
        include Thor::Actions

        PERMITTED_CLI_TOOLS = %i[brew node nvm].freeze

        private

        def file_exist?(path)
          File.exist?(File.join(destination_root, *path))
        end

        def ask_for_response(question)
          answer = ask(question)

          if answer == ''
            say_error('No answer given, finishing.', :red)
            abort
          end

          answer
        end

        def installed?(tool)
          unless PERMITTED_CLI_TOOLS.include?(tool)
            say_error("Unexpected tool: #{tool.inspect}", :red)
            abort
          end

          return nvm_installed? if tool == :nvm

          system("command -v #{tool} &> /dev/null")
        end

        # NVM doesn't work in non-interactive shells
        def nvm_installed?
          system('test -f "${HOME}/.nvm/nvm.sh"')
        end

        def rails_app?
          file_exist?('Gemfile')
        end

        def install_homebrew
          return if installed?(:brew)

          say 'Visit https://brew.sh to install Homebrew and re-run this command.'
        end
      end
    end
  end
end
