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

        def test_rule_id_defaults_to_the_feature_path
          assert_equal 'audit/github/test_rule', TestRule.rule_id
        end

        def test_rule_id_override_is_inherited_and_used_by_the_registry
          # Like a plugin's own base class giving all its rules short IDs
          plugin_base = Class.new(Rules::Base) { def self.rule_id = 'plugin/short' }

          assert_equal 'plugin/short', Rules::Registry.id_for(Class.new(plugin_base), :plugin_rule)
        end

        def test_anonymous_rule_id_falls_back_to_the_registered_name
          assert_equal 'some_rule', Rules::Registry.id_for(Class.new(Rules::Base), :some_rule)
        end

        def test_register_raises_when_rule_ids_clash
          Rules::Registry.register(Class.new(Rules::Base) { def self.rule_id = 'same' }, :first_rule)

          error = assert_raises(ArgumentError) do
            Rules::Registry.register(Class.new(Rules::Base) { def self.rule_id = 'same' }, :second_rule)
          end
          assert_match(/"same" is already used/, error.message)
        ensure
          Rules::Registry.unregister(:first_rule, :second_rule)
        end
      end
    end
  end
end
