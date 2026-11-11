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
          assert_equal true, audited_rule(fix: true).fix
        end

        def test_audit_passes_fix_false_to_rules
          assert_equal false, audited_rule(fix: false).fix
        end

        private

        # Audits a stubbed repo with a single passing rule and returns that rule instance
        def audited_rule(fix:)
          auditor = Auditor.new('test_token', 'test_org', fix)
          auditor.instance_variable_set(:@client, stub(get: []))

          Rules::Registry.register(Class.new(Rules::Base) { def validate = :passed }, :test_rule)

          rule_instance = nil
          auditor.audit(stub(full_name: 'test_org/test_repo')) { |rule| rule_instance = rule }
          rule_instance
        ensure
          Rules::Registry.unregister(:test_rule)
        end
      end
    end
  end
end
