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

              @rules[rule_name] = klass
            end

            # Short, stable ID for a rule class: its feature path, e.g. "versioning/semver".
            # Anonymous classes (e.g. in tests) fall back to the registered rule name.
            def id_for(klass, rule_name)
              return rule_name.to_s unless klass.name

              klass.name.delete_prefix('WayOfWorking::').delete_suffix('::GithubAuditRule').underscore
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
