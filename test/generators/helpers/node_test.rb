# frozen_string_literal: true

require 'test_helper'
require 'way_of_working/generators/helpers/node'

module WayOfWorking
  module Generators
    module Helpers
      # This is a Thor generator used to test the package manager helper methods
      class NodePackageManagerTester < Thor::Group
        include WayOfWorking::Generators::Helpers::Node

        FINISHED = 'Finished successfully!'

        def output_node_package_manager
          say("node_package_manager: #{node_package_manager.inspect}")
        end

        def finished
          say(FINISHED)
        end
      end

      # This is a Thor generator used to test the version helper methods
      class NodeVersionTester < Thor::Group
        include WayOfWorking::Generators::Helpers::Node

        FINISHED = 'Finished successfully!'

        def output_nvm_node_version
          say("nvm_node_version: #{nvm_node_version.inspect}")
          say("nvm_node_version_description: #{nvm_node_version_description.inspect}")
        end

        def finished
          say(FINISHED)
        end
      end

      # This is a Thor generator used to test the nvm installer helper method
      class NodeInstallNVMTester < Thor::Group
        include WayOfWorking::Generators::Helpers::Node

        FINISHED = 'Finished successfully!'

        def now_install_nvm
          install_nvm
        end

        def finished
          say(FINISHED)
        end
      end

      # This is a Thor generator used to test the node installer helper method
      class NodeInstallNodeTester < Thor::Group
        include WayOfWorking::Generators::Helpers::Node

        FINISHED = 'Finished successfully!'

        def now_install_node
          install_node
        end

        def finished
          say(FINISHED)
        end
      end

      # This class tests the EndToEndTests::Init Thor Group (generator)
      class NodeTest < Rails::Generators::TestCase
        # tests NodePackageManagerTester
        destination WayOfWorking.root.join('tmp/generators')
        setup :prepare_destination

        test 'generator runs without errors' do
          self.generator_class = NodePackageManagerTester
          copy WayOfWorking.root.join('test', 'resources', 'cypress_package-lock.json'),
               destination_root.join('package-lock.json')

          assert_nothing_raised do
            run_generator
          end
        end

        test 'node_package_manager with package-lock.json' do
          self.generator_class = NodePackageManagerTester

          copy WayOfWorking.root.join('test', 'resources', 'cypress_package-lock.json'),
               destination_root.join('package-lock.json')

          assert_file 'package-lock.json'

          stdout = run_generator
          assert_match('node_package_manager: :npm', stdout)
        end

        test 'node_package_manager with npm-shrinkwrap.json' do
          self.generator_class = NodePackageManagerTester

          copy WayOfWorking.root.join('test', 'resources', 'cypress_npm-shrinkwrap.json'),
               destination_root.join('npm-shrinkwrap.json')

          assert_file 'npm-shrinkwrap.json'

          stdout = run_generator
          assert_match('node_package_manager: :npm', stdout)
        end

        test 'node_package_manager with yarn.lock' do
          self.generator_class = NodePackageManagerTester

          copy WayOfWorking.root.join('test', 'resources', 'cypress_yarn.lock'),
               destination_root.join(generator_class::DEFAULT_YARN_LOCK_FILE)

          assert_file generator_class::DEFAULT_YARN_LOCK_FILE

          stdout = run_generator
          assert_match('node_package_manager: :yarn', stdout)
        end

        test 'node_package_manager with .yarnrc.yml and custom yarn.lock' do
          self.generator_class = NodePackageManagerTester

          copy WayOfWorking.root.join('test', 'resources', 'cypress_yarn.lock'),
               destination_root.join('custom_location_yarn.lock')
          copy WayOfWorking.root.join('test', 'resources', 'custom_location_yarnrc.yml'),
               destination_root.join(generator_class::YARNRC_FILENAME)

          assert_file generator_class::YARNRC_FILENAME
          assert_file 'custom_location_yarn.lock'

          stdout = run_generator
          assert_match('node_package_manager: :yarn', stdout)
        end

        test 'node_package_manager with no lock file and npm choice' do
          self.generator_class = NodePackageManagerTester

          generator_class.any_instance.expects(:ask).
            with('Which javascript package manager do you wish to use? (yarn/npm)').
            returns('NpM')

          stdout = run_generator
          assert_match('node_package_manager: :npm', stdout)
        end

        test 'node_package_manager with no lock file and yarn choice' do
          self.generator_class = NodePackageManagerTester

          generator_class.any_instance.expects(:ask).
            with('Which javascript package manager do you wish to use? (yarn/npm)').
            returns('yaRn')

          stdout = run_generator
          assert_match('node_package_manager: :yarn', stdout)
        end

        test 'node_package_manager with no lock file and invalid choice' do
          self.generator_class = NodePackageManagerTester

          generator_class.any_instance.expects(:ask).
            with('Which javascript package manager do you wish to use? (yarn/npm)').
            returns('bob')

          stdout = ''
          stderr = capture(:stderr) do
            assert_raise ::SystemExit do
              stdout = run_generator
            end
          end

          assert_match('No recognisable answer given, finishing.', stderr)
          assert_no_match('node_package_manager:', stdout)
          assert_no_match(generator_class::FINISHED, stdout)
        end

        test 'node_package_manager with no lock file and no choice' do
          self.generator_class = NodePackageManagerTester
          generator_class.any_instance.expects(:ask).
            with('Which javascript package manager do you wish to use? (yarn/npm)').
            returns('')

          stdout = ''
          stderr = capture(:stderr) do
            assert_raise ::SystemExit do
              stdout = run_generator
            end
          end

          assert_match('No answer given, finishing.', stderr)
          assert_no_match('node_package_manager:', stdout)
          assert_no_match(generator_class::FINISHED, stdout)
        end

        test 'nvm_node_version with node 18' do
          self.generator_class = NodeVersionTester

          File.write(destination_root.join(generator_class::NVMRC_FILENAME), '18')

          assert_file generator_class::NVMRC_FILENAME

          stdout = run_generator
          assert_match('nvm_node_version: "18"', stdout)
          assert_match('nvm_node_version_description: "node version 18"', stdout)
        end

        test 'nvm_node_version with LTS node' do
          self.generator_class = NodeVersionTester

          File.write(destination_root.join(generator_class::NVMRC_FILENAME), 'lts/*')

          assert_file generator_class::NVMRC_FILENAME

          stdout = run_generator
          assert_match('nvm_node_version: "lts/*"', stdout)
          assert_match('nvm_node_version_description: "the latest Long Term Support (LTS) version of node"', stdout)
        end

        test 'nvm_node_version with no nvmrc file' do
          self.generator_class = NodeVersionTester

          assert_no_file generator_class::NVMRC_FILENAME

          stdout = run_generator
          assert_match('nvm_node_version: nil', stdout)
          assert_match('nvm_node_version_description: nil', stdout)
        end

        test 'install_nvm with nvm already installed' do
          self.generator_class = NodeInstallNVMTester

          generator_class.any_instance.expects(:installed?).with(:nvm).returns(true)
          generator_class.any_instance.expects(:ask_for_response).never

          stdout = run_generator
          assert_match(generator_class::FINISHED, stdout)
        end

        test 'install_nvm with user not wanting to install' do
          self.generator_class = NodeInstallNVMTester

          generator_class.any_instance.expects(:installed?).with(:nvm).returns(false)
          generator_class.any_instance.expects(:ask).
            with('Do you wish to install nvm via Homebrew? (y/n)').
            returns('nO')
          generator_class.any_instance.expects(:install_homebrew).never

          stdout = ''
          stderr = capture(:stderr) do
            assert_raise ::SystemExit do
              stdout = run_generator
            end
          end

          assert_match('install nvm and re-run this command.', stderr)
          assert_no_match(generator_class::FINISHED, stdout)
        end

        test 'install_nvm with user wanting to install' do
          self.generator_class = NodeInstallNVMTester

          generator_class.any_instance.expects(:installed?).with(:nvm).returns(false)
          generator_class.any_instance.expects(:ask).
            with('Do you wish to install nvm via Homebrew? (y/n)').
            returns('YeS')
          generator_class.any_instance.expects(:install_homebrew).returns(nil)
          ::Object.any_instance.stubs(:system).with('brew install nvm').returns(true)

          stdout = run_generator

          assert_match('Installing nvm...', stdout)
          assert_match(generator_class::FINISHED, stdout)
        end

        test 'install_node with node already installed' do
          self.generator_class = NodeInstallNodeTester

          generator_class.any_instance.expects(:installed?).with(:node).returns(true)
          generator_class.any_instance.expects(:ask_for_response).never

          stdout = run_generator
          assert_match(generator_class::FINISHED, stdout)
        end

        test 'install_node with user not wanting to install' do
          self.generator_class = NodeInstallNodeTester

          generator_class.any_instance.expects(:installed?).with(:node).returns(false)
          generator_class.any_instance.expects(:ask).
            with('Do you wish to install node via nvm (y/n)').
            returns('nO')
          generator_class.any_instance.expects(:install_nvm).never

          stdout = ''
          stderr = capture(:stderr) do
            assert_raise ::SystemExit do
              stdout = run_generator
            end
          end

          assert_match('Visit https://nodejs.org to install node', stderr)
          assert_no_match(generator_class::FINISHED, stdout)
        end

        test 'install_node with user wanting to install without nvmrc file' do
          self.generator_class = NodeInstallNodeTester

          generator_class.any_instance.expects(:installed?).with(:node).returns(false)
          generator_class.any_instance.expects(:ask).
            with('Do you wish to install node via nvm (y/n)').
            returns('YeS')
          generator_class.any_instance.expects(:install_nvm).returns(nil)
          ::Object.any_instance.stubs(:system).with('. $NVM_DIR/nvm.sh && nvm use').returns(true)

          assert_no_file generator_class::NVMRC_FILENAME

          stdout = run_generator

          assert_file generator_class::NVMRC_FILENAME do |content|
            assert_match('lts/*', content)
          end
          assert_match('Installing node...', stdout)
          assert_match(generator_class::FINISHED, stdout)
        end

        test 'install_node with user wanting to install with nvmrc file' do
          self.generator_class = NodeInstallNodeTester

          generator_class.any_instance.expects(:installed?).with(:node).returns(false)
          generator_class.any_instance.expects(:ask).
            with('Do you wish to install node via nvm (y/n)').
            returns('YeS')
          generator_class.any_instance.expects(:install_nvm).returns(nil)
          ::Object.any_instance.stubs(:system).with('. $NVM_DIR/nvm.sh && nvm use').returns(true)

          File.write(destination_root.join(generator_class::NVMRC_FILENAME), '18')

          assert_file generator_class::NVMRC_FILENAME do |content|
            assert_match('18', content)
          end

          stdout = run_generator

          assert_file generator_class::NVMRC_FILENAME do |content|
            assert_match('18', content)
          end
          assert_match('Installing node...', stdout)
          assert_match(generator_class::FINISHED, stdout)
        end
      end
    end
  end
end
