# frozen_string_literal: true

require 'test_helper'

module WayOfWorking
  module Audit
    module Github
      class AuditorTest < Minitest::Test
        def test_initialize_without_fix_parameter
          auditor = Auditor.new('test_token', 'test_org')

          # We can't directly access @fix, but we can verify it's passed to rules
          # by checking the audit method behavior
          assert_instance_of Auditor, auditor
        end

        def test_initialize_with_fix_false
          auditor = Auditor.new('test_token', 'test_org', false)

          assert_instance_of Auditor, auditor
        end

        def test_initialize_with_fix_true
          auditor = Auditor.new('test_token', 'test_org', true)

          assert_instance_of Auditor, auditor
        end

        def test_audit_passes_fix_to_rules
          # Create auditor with fix=true
          auditor = Auditor.new('test_token', 'test_org', true)

          # Mock the client
          mock_client = mock
          mock_client.stubs(:get).returns([])

          # Stub the private client method using instance_variable_set
          auditor.instance_variable_set(:@client, mock_client)

          # Mock repository
          mock_repo = stub(full_name: 'test_org/test_repo')

          # Register a test rule
          test_rule_class = Class.new(Rules::Base) do
            def validate
              :passed
            end
          end
          Rules::Registry.register(test_rule_class, :test_rule)

          # Capture the rule instance to verify fix parameter
          rule_instance = nil
          auditor.audit(mock_repo) do |rule|
            rule_instance = rule
          end

          # Verify the rule was created with fix=true
          assert_equal true, rule_instance.fix
        ensure
          # Clean up
          Rules::Registry.unregister(:test_rule)
        end

        def test_audit_passes_fix_false_to_rules
          # Create auditor with fix=false (default)
          auditor = Auditor.new('test_token', 'test_org', false)

          # Mock the client
          mock_client = mock
          mock_client.stubs(:get).returns([])

          # Stub the private client method using instance_variable_set
          auditor.instance_variable_set(:@client, mock_client)

          # Mock repository
          mock_repo = stub(full_name: 'test_org/test_repo')

          # Register a test rule
          test_rule_class = Class.new(Rules::Base) do
            def validate
              :passed
            end
          end
          Rules::Registry.register(test_rule_class, :test_rule)

          # Capture the rule instance to verify fix parameter
          rule_instance = nil
          auditor.audit(mock_repo) do |rule|
            rule_instance = rule
          end

          # Verify the rule was created with fix=false
          assert_equal false, rule_instance.fix
        ensure
          # Clean up
          Rules::Registry.unregister(:test_rule)
        end
      end
    end
  end
end
