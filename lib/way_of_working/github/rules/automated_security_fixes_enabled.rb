# frozen_string_literal: true

require_relative 'base'

module WayOfWorking
  module Github
    # This is the namespace for GitHub rules
    module Rules
      # This rule checks for enabled automated security fixes.
      class AutomatedSecurityFixesEnabled < Base
        def valid?
          if @client.automated_security_fixes_enabled?(@repo_name)
            @errors << 'Automated security fixes not enabled'
          end

          @errors.empty? ? :passed : :failed
        end
      end

      Registry.register(AutomatedSecurityFixesEnabled, 'Automated Security Fixes Enabled')
    end
  end
end
