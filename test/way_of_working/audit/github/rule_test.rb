# frozen_string_literal: true

require 'test_helper'

module WayOfWorking
  module Audit
    module Github
      class TestRule < Rules::Base
      end

      class RuleTest < Minitest::Test
        def test_tags
          # Test class method
          assert_equal [:way_of_working], TestRule.tags

          # Test instance method
          client = mock
          name = mock
          repo = stub(full_name: 'test')
          rulesets = mock
          test_rule = TestRule.new(client, name, repo, rulesets)
          assert_equal [:way_of_working], test_rule.tags
        end

        def test_initialize_without_fix_parameter
          client = mock
          name = mock
          repo = stub(full_name: 'test/repo')
          rulesets = mock

          test_rule = TestRule.new(client, name, repo, rulesets)

          assert_equal false, test_rule.fix
        end

        def test_initialize_with_fix_false
          client = mock
          name = mock
          repo = stub(full_name: 'test/repo')
          rulesets = mock

          test_rule = TestRule.new(client, name, repo, rulesets, false)

          assert_equal false, test_rule.fix
        end

        def test_initialize_with_fix_true
          client = mock
          name = mock
          repo = stub(full_name: 'test/repo')
          rulesets = mock

          test_rule = TestRule.new(client, name, repo, rulesets, true)

          assert_equal true, test_rule.fix
        end
      end
    end
  end
end
