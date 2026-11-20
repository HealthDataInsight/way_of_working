# frozen_string_literal: true

require_relative 'unknown'

module WayOfWorking
  module Audit
    module Github
      module Rules
        # This provides the GitHub audit rule factory
        module Registry
          class << self
            attr_accessor :rules

            def register(klass, rule_name)
              @rules ||= {}
              id = id_for(klass, rule_name)
              clash = @rules.find { |name, other| name != rule_name && id_for(other, name) == id }
              raise ArgumentError, "Audit rule ID #{id.inspect} is already used by #{clash.last}" if clash

              @rules[rule_name] = klass
            end

            # The rule's `rule_id`, or its registered name for anonymous classes (e.g. in tests)
            def id_for(klass, rule_name)
              klass.rule_id || rule_name.to_s
            end

            def unregister(*rule_names)
              rule_names.each do |rule_name|
                @rules.delete(rule_name)
              end
            end

            def rule(rule_name, client, repo)
              klass = Registry.rules.fetch(rule_name, Unknown)

              klass.new(client, repo)
            end
          end
        end
      end
    end
  end
end
