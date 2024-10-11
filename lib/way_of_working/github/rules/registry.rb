# frozen_string_literal: true

module WayOfWorking
  module Github
    module Rules
      # This provides a WowBot bot factory
      module Registry
        class << self
          attr_accessor :rules

          def register(klass, rule_name)
            @rules ||= {}

            @rules[rule_name] = klass
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

require_relative 'all'
