require 'test_helper'
require 'tmpdir'

module WayOfWorking
  module CodeOfConduct
    module ContributorCovenant
      module Generators
        # This class tests the CodeOfConduct::Init Thor Group (generator)
        class InitTest < Rails::Generators::TestCase
          tests WayOfWorking::CodeOfConduct::ContributorCovenant::Generators::Init
          destination WayOfWorking.root.join('tmp/generators')
          setup :prepare_destination

          setup do
            WayOfWorking::Config.stubs(:path).returns(Pathname.new(Dir.mktmpdir).join('config.yaml'))
            Init.any_instance.stubs(:yes?).returns(false)
          end

          test 'generator requires a contact method, from the option or the config file' do
            stderr = capture(:stderr) { run_generator }
            assert_match('No contact method provided', stderr)

            stderr = capture(:stderr) { run_generator %w[--contact-method foo@bar.com] }
            refute_match('No contact method provided', stderr)
          end

          test 'falls back to the contact method stored in the config file' do
            WayOfWorking::Config.set('code_of_conduct.contact_method', 'stored@example.com')

            run_generator

            assert_file 'CODE_OF_CONDUCT.md' do |content|
              assert_match('stored@example.com', content)
            end
          end

          test 'offers to remember a contact method given on the command line' do
            Init.any_instance.expects(:yes?).returns(true)

            run_generator %w[--contact-method foo@bar.com]

            assert_equal 'foo@bar.com', WayOfWorking::Config.get('code_of_conduct.contact_method')
          end

          test 'does not offer to remember a contact method already matching the config file' do
            WayOfWorking::Config.set('code_of_conduct.contact_method', 'foo@bar.com')
            Init.any_instance.expects(:yes?).never

            run_generator %w[--contact-method foo@bar.com]
          end

          test 'COC file is created and revoked' do
            code_of_conduct_file = 'CODE_OF_CONDUCT.md'
            run_generator %w[--contact-method foo@bar.com]

            assert_file code_of_conduct_file do |content|
              assert_match('## Our Pledge', content)
              refute_match('[INSERT CONTACT METHOD]', content)
            end
            assert_file 'docs/way_of_working/code-of-conduct.md'

            run_generator %w[--contact-method foo@bar.com], behavior: :revoke

            assert_no_file code_of_conduct_file
            assert_no_file 'docs/way_of_working/code-of-conduct.md'
          end
        end
      end
    end
  end
end
