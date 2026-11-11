# frozen_string_literal: true

require 'test_helper'
require 'tmpdir'

module WayOfWorking
  module CodeOfConduct
    module ContributorCovenantV3
      module Generators
        # This class tests the Contributor Covenant v3 Init Thor Group (generator). Contact method
        # handling is inherited from, and tested with, the v2.1 generator.
        class InitTest < Rails::Generators::TestCase
          tests WayOfWorking::CodeOfConduct::ContributorCovenantV3::Generators::Init
          destination WayOfWorking.root.join('tmp/generators')
          setup :prepare_destination

          setup do
            WayOfWorking::Config.stubs(:path).returns(Pathname.new(Dir.mktmpdir).join('config.yaml'))
            Init.any_instance.stubs(:yes?).returns(false)
          end

          test 'v3 COC file is created and revoked' do
            run_generator %w[--contact-method foo@bar.com]

            assert_file 'CODE_OF_CONDUCT.md' do |content|
              assert_match('# Contributor Covenant 3.0 Code of Conduct', content)
              assert_match('Community Moderators at <foo@bar.com>.', content)
              refute_match('[NOTE:', content)
            end
            assert_file 'docs/way_of_working/code-of-conduct.md', %r{version/3/0/}

            run_generator %w[--contact-method foo@bar.com], behavior: :revoke

            assert_no_file 'CODE_OF_CONDUCT.md'
            assert_no_file 'docs/way_of_working/code-of-conduct.md'
          end
        end
      end
    end
  end
end
