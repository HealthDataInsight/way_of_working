# frozen_string_literal: true

require 'test_helper'
require 'open3'

module WayOfWorking
  module Audit
    module Github
      # Loads each rule file in a fresh process, so require order bugs (e.g. a
      # circular require) raise instead of being masked by what's already loaded.
      class RuleLoadTest < Minitest::Test
        Dir[File.expand_path('../../../../lib/way_of_working/**/github_audit_rule.rb', __dir__)].each do |path|
          feature = path[%r{lib/(way_of_working/.+)/github_audit_rule\.rb}, 1]

          define_method("test_#{feature.tr('/', '_')}_rule_loads_on_its_own") do
            _out, err, status = Open3.capture3(
              RbConfig.ruby, '-Ilib', '-e', "require 'way_of_working'; require '#{feature}/github_audit_rule'"
            )

            assert_predicate status, :success?, err
          end
        end
      end
    end
  end
end
