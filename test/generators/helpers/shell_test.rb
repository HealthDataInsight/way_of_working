# frozen_string_literal: true

require 'test_helper'
require 'way_of_working/generators/helpers/shell'

module WayOfWorking
  module Generators
    module Helpers
      # This is a Thor generator used to test the brew installer helper method
      class ShellInstallHomebrewTester < Thor::Group
        include WayOfWorking::Generators::Helpers::Node

        FINISHED = 'Finished successfully!'

        def now_install_homebrew
          install_homebrew
        end

        def finished
          say(FINISHED)
        end
      end

      # This is a Thor generator used to test the ask_for_response helper method
      class ShellResponseTester < Thor::Group
        include WayOfWorking::Generators::Helpers::Node

        FINISHED = 'Finished successfully!'

        def prompt_now
          answer = ask_for_response('Well?')
          say("ask_for_response: #{answer.inspect}")
        end

        def finished
          say(FINISHED)
        end
      end

      # This is a Thor generator used to test the package manager helper methods
      class ShellMiscellaneousTester < Thor::Group
        include WayOfWorking::Generators::Helpers::Shell

        FINISHED = 'Finished successfully!'

        # ask_for_response(question)

        def check_file_exist
          say("file_exist?: #{file_exist?('proof.txt').inspect}")
        end

        def check_an_installed_tool
          answer = ask('What tool do you want to check is installed?')

          return unless answer != ''

          tool = answer.to_sym
          say("installed?(#{tool.inspect}): #{installed?(tool).inspect}")
        end

        def output_nvm_installed
          say("nvm_installed?: #{nvm_installed?.inspect}")
        end

        def output_rails_app
          say("rails_app?: #{rails_app?.inspect}")
        end

        def finished
          say(FINISHED)
        end
      end

      # This class tests the EndToEndTests::Init Thor Group (generator)
      class ShellTest < Rails::Generators::TestCase
        tests ShellMiscellaneousTester
        destination WayOfWorking.root.join('tmp/generators')
        setup :prepare_destination

        test 'install_homebrew with brew already installed' do
          self.generator_class = ShellInstallHomebrewTester

          generator_class.any_instance.expects(:installed?).with(:brew).returns(true)

          stdout = run_generator
          assert_no_match('Visit https://brew.sh to install Homebrew', stdout)
          assert_match(generator_class::FINISHED, stdout)
        end

        test 'install_homebrew with brew not already installed' do
          self.generator_class = ShellInstallHomebrewTester

          generator_class.any_instance.expects(:installed?).with(:brew).returns(false)

          stdout = run_generator
          assert_match('Visit https://brew.sh to install Homebrew', stdout)
          assert_match(generator_class::FINISHED, stdout)
        end

        test 'generator runs without errors' do
          generator_class.any_instance.expects(:ask).with('What tool do you want to check is installed?').returns('')

          assert_nothing_raised do
            run_generator
          end
        end

        test 'ask_for_response with no response' do
          self.generator_class = ShellResponseTester

          generator_class.any_instance.expects(:ask).with('Well?').returns('')

          stdout = ''
          stderr = capture(:stderr) do
            assert_raise ::SystemExit do
              stdout = run_generator
            end
          end

          assert_match('No answer given, finishing.', stderr)
          assert_no_match('ask_for_response:', stdout)
          assert_no_match(generator_class::FINISHED, stdout)
        end

        test 'ask_for_response with response' do
          self.generator_class = ShellResponseTester
          generator_class.any_instance.expects(:ask).with('Well?').returns('What?')

          stdout = run_generator

          assert_match('ask_for_response: "What?"', stdout)
          assert_match(generator_class::FINISHED, stdout)
        end

        test 'file_exist? with no file' do
          generator_class.any_instance.expects(:ask).with('What tool do you want to check is installed?').returns('')

          stdout = run_generator

          assert_match('file_exist?: false', stdout)
        end

        test 'file_exist? with proof file' do
          generator_class.any_instance.expects(:ask).with('What tool do you want to check is installed?').returns('')
          File.write(destination_root.join('proof.txt'), 'If proof were needed...')

          assert_file('proof.txt')

          stdout = run_generator

          assert_match('file_exist?: true', stdout)
        end

        test 'installed? with unpermitted tool' do
          generator_class.any_instance.expects(:ask).with('What tool do you want to check is installed?').returns('sudo')

          stderr = capture(:stderr) do
            assert_raise ::SystemExit do
              run_generator
            end
          end
          assert_match('Unexpected tool: :sudo', stderr)
        end

        test 'installed? with brew installed' do
          generator_class.any_instance.expects(:ask).with('What tool do you want to check is installed?').returns('brew')
          ::Object.any_instance.expects(:system).with('command -v brew &> /dev/null').returns(true)
          ::Object.any_instance.expects(:system).with('test -f "${HOME}/.nvm/nvm.sh"').returns(true)

          stdout = run_generator

          assert_match('installed?(:brew): true', stdout)
        end

        test 'installed? with brew not installed' do
          generator_class.any_instance.expects(:ask).with('What tool do you want to check is installed?').returns('brew')
          ::Object.any_instance.expects(:system).with('command -v brew &> /dev/null').returns(false)
          ::Object.any_instance.expects(:system).with('test -f "${HOME}/.nvm/nvm.sh"').returns(true)

          stdout = run_generator

          assert_match('installed?(:brew): false', stdout)
        end

        test 'installed? with nvm installed' do
          generator_class.any_instance.expects(:ask).with('What tool do you want to check is installed?').returns('nvm')
          ::Object.any_instance.expects(:system).with('command -v brew &> /dev/null').never
          ::Object.any_instance.expects(:system).with('test -f "${HOME}/.nvm/nvm.sh"').returns(true).twice

          stdout = run_generator

          assert_match('installed?(:nvm): true', stdout)
        end

        test 'installed? with nvm not installed' do
          generator_class.any_instance.expects(:ask).with('What tool do you want to check is installed?').returns('nvm')
          ::Object.any_instance.expects(:system).with('command -v brew &> /dev/null').never
          ::Object.any_instance.expects(:system).with('test -f "${HOME}/.nvm/nvm.sh"').returns(false).twice

          stdout = run_generator

          assert_match('installed?(:nvm): false', stdout)
        end

        test 'nvm_installed? with nvm installed' do
          generator_class.any_instance.expects(:ask).with('What tool do you want to check is installed?').returns('')
          ::Object.any_instance.expects(:system).with('test -f "${HOME}/.nvm/nvm.sh"').returns(true)

          stdout = run_generator

          assert_match('nvm_installed?: true', stdout)
        end

        test 'nvm_installed? with nvm not installed' do
          generator_class.any_instance.expects(:ask).with('What tool do you want to check is installed?').returns('')
          ::Object.any_instance.expects(:system).with('test -f "${HOME}/.nvm/nvm.sh"').returns(false)

          stdout = run_generator

          assert_match('nvm_installed?: false', stdout)
        end

        test 'rails_app with no Gemfile' do
          generator_class.any_instance.expects(:ask).with('What tool do you want to check is installed?').returns('')
          assert_no_file 'Gemfile'

          stdout = run_generator

          assert_match('rails_app?: false', stdout)
          assert_no_file 'Gemfile'
        end

        test 'rails_app with Gemfile' do
          generator_class.any_instance.expects(:ask).with('What tool do you want to check is installed?').returns('')
          copy WayOfWorking.root.join('test', 'resources', 'vanilla_rails_Gemfile'),
               destination_root.join('Gemfile')

          assert_file 'Gemfile'

          stdout = run_generator

          assert_match('rails_app?: true', stdout)
        end
      end
    end
  end
end
