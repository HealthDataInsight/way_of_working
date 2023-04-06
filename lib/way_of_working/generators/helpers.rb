# frozen_string_literal: true

module WayOfWorking
  module Generators
    # Helper methods to include in generators
    module Helpers
      YARNRC_FILENAME = '.yarnrc.yml'.freeze
      PERMITTED_CLI_TOOLS = %i[brew node nvm].freeze

      private

      def file_exist?(path)
        File.exist?(File.join(destination_root, *path))
      end

      def ask_for_response(question)
        answer = ask(question)

        abort(Rainbow("\nNo answer given, finishing.").red) if answer == ''

        answer
      end

      def installed?(tool)
        raise ArgumentError, "Unexpected tool: #{tool}" unless PERMITTED_CLI_TOOLS.include?(tool)
        return nvm_installed? if tool == :nvm

        system("command -v #{tool} &> /dev/null")
      end

      # NVM doesn't work in non-interactive shells
      def nvm_installed?
        system('test -f "${HOME}/.nvm/nvm.sh"')
      end

      def npm_package_manager_used?
        file_exist?('package-lock.json') || file_exist?('npm-shrinkwrap.json')
      end

      def yarn_package_manager_used?
        yarn_lock_file = 'yarn.lock'

        # Check if there is a yarnrc file that specifies a different lock file name
        if file_exist?(YARNRC_FILENAME)
          yarnrc_hash = YAML.safe_load_file(YARNRC_FILENAME)
          yarn_lock_file = yarnrc_hash.fetch('lockfileFilename', yarn_lock_file)
        end

        file_exist?(yarn_lock_file)
      end

      def package_manager
        return :npm if npm_package_manager_used?
        return :yarn if yarn_package_manager_used?

        # Not obvious from the code, so ask
        answer = ask_for_response('Which javascript package manager do you wish to use? (yarn/npm)')
        return :yarn if /\Ayarn/i.match?(answer)
        return :npm if /\Anpm/i.match?(answer)

        abort(Rainbow("\nNo recognisable answer given, finishing.").red)
      end

      def node_version_description
        node_version = File.read(File.expand_path('.nvmrc', destination_root)).strip

        return 'the latest Long Term Support (LTS) version of node' if node_version == 'lts/*'

        "node version #{node_version}"
      end

      def rails_app?
        file_exist?('Gemfile')
      end

      def install_homebrew
        return if installed?(:brew)

        say 'Visit https://brew.sh to install Homebrew and re-run this command.'
      end

      def install_nvm
        return if installed?(:nvm)

        answer = ask_for_response('Do you wish to install nvm via Homebrew? (y/n)')

        if /\Ay/i.match?(answer)
          # Install dependencies
          install_homebrew

          say 'Installing nvm...'
          system('brew install nvm')
        else
          abort "\nVisit https://github.com/nvm-sh/nvm#installing-and-updating to " \
                'install nvm and re-run this command.'
        end
      end

      def install_node
        return if installed?(:node)

        create_file('.nvmrc', 'lts/*') unless file_exist?('.nvmrc')

        answer = ask_for_response('Do you wish to install ' \
                                  "#{node_version_description} via nvm (y/n)")

        if /\Ay/i.match?(answer)
          # Install dependencies
          install_nvm

          say 'Installing node...'
          system('. $NVM_DIR/nvm.sh && nvm use')
        else
          abort("\nVisit https://nodejs.org to install node")
        end
      end
    end
  end
end
