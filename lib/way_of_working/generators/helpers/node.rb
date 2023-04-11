# frozen_string_literal: true

require 'active_support/concern'
require 'rainbow'
require 'thor/actions'
require 'way_of_working/generators/helpers/shell'
require 'yaml'

module WayOfWorking
  module Generators
    module Helpers
      # Node helper methods for generators
      module Node
        extend ActiveSupport::Concern

        include Thor::Actions
        include WayOfWorking::Generators::Helpers::Shell

        YARNRC_FILENAME = '.yarnrc.yml'
        NVMRC_FILENAME = '.nvmrc'
        DEFAULT_YARN_LOCK_FILE = 'yarn.lock'

        private

        def npm_package_manager_used?
          file_exist?('package-lock.json') || file_exist?('npm-shrinkwrap.json')
        end

        def yarn_package_manager_used?
          yarn_lock_file = DEFAULT_YARN_LOCK_FILE

          # Check if there is a yarnrc file that specifies a different lock file name
          if file_exist?(YARNRC_FILENAME)
            yarnrc_hash = YAML.safe_load(File.read(File.join(destination_root, YARNRC_FILENAME)))
            yarn_lock_file = yarnrc_hash.fetch('lockfileFilename', yarn_lock_file)
          end

          file_exist?(yarn_lock_file)
        end

        # This returns :npm or :yarn depending on the project config or user choice.
        def node_package_manager
          return :npm if npm_package_manager_used?
          return :yarn if yarn_package_manager_used?

          # Not obvious from the code, so ask
          answer = ask_for_response('Which javascript package manager do you wish to use? ' \
                                    '(yarn/npm)')
          return :yarn if /\Ayarn/i.match?(answer)
          return :npm if /\Anpm/i.match?(answer)

          say_error('No recognisable answer given, finishing.', :red)
          abort
        end

        def nvm_node_version
          return unless file_exist?(NVMRC_FILENAME)

          File.read(File.join(destination_root, NVMRC_FILENAME)).strip
        end

        def nvm_node_version_description
          return unless nvm_node_version
          return 'the latest Long Term Support (LTS) version of node' if nvm_node_version == 'lts/*'

          "node version #{nvm_node_version}"
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
            abort("\nVisit https://github.com/nvm-sh/nvm#installing-and-updating to " \
                  'install nvm and re-run this command.')
          end
        end

        def install_node
          return if installed?(:node)

          answer = ask_for_response('Do you wish to install node via nvm (y/n)')

          if /\Ay/i.match?(answer)
            # Install dependencies
            install_nvm

            create_file(NVMRC_FILENAME, 'lts/*') unless file_exist?(NVMRC_FILENAME)

            say 'Installing node...'
            system('. $NVM_DIR/nvm.sh && nvm use')
          else
            abort("\nVisit https://nodejs.org to install node")
          end
        end
      end
    end
  end
end
