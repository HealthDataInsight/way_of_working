# frozen_string_literal: true

require 'way_of_working/audit/github/rules/base'

module WayOfWorking
  module Versioning
    # The namespace for this plugin
    module Semver
      # This rule checks for the versioning documentation
      class GithubAuditRule < ::WayOfWorking::Audit::Github::Rules::Base
        source_root WayOfWorking.root.join('lib', 'way_of_working', 'versioning', 'semver', 'templates')

        def validate
          validate_repo_file_contains_source_file(
            'docs/way_of_working/versioning.md'
          )
        end

        private

        def validate_repo_file_contains_source_file(*paths)
          paths.each do |path|
            if repo_file_contents(path).nil?
              @errors << "#{path} missing"
              next
            end

            @errors << "#{path} does not match the source template" unless repo_file_contains_source_file?(path)
          end
        end
      end

      ::WayOfWorking::Audit::Github::Rules::Registry.register(
        GithubAuditRule, 'Semantic Versioning'
      )
    end
  end
end
