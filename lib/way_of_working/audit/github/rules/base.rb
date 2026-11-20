# frozen_string_literal: true

# ponytail: only what Base itself needs. Every command loads this via readme_badge, so
# Octokit and the rest of ActiveSupport wait for the auditor (auditor.rb).
require 'active_support'
require 'active_support/core_ext/string/inflections'
require 'base64'

module WayOfWorking
  module Audit
    module Github
      module Rules
        # This is the base class for GitHub audit rules
        class Base
          attr_accessor :errors, :name, :rulesets, :warnings
          attr_reader :fix

          class << self
            # Stores and return the source root for this class
            def source_root(path = nil)
              @source_root = path if path
              @source_root ||= nil
            end
          end

          def initialize(client, name, repo, rulesets, fix = false)
            @client = client
            @name = name
            @repo = repo
            @repo_name = repo.full_name
            @rulesets = rulesets
            @fix = fix
            @errors = []
            @warnings = []
          end

          def status
            @status ||= begin
              result = validate

              if result == :not_applicable
                result
              else
                @errors.empty? ? :passed : :failed
              end
            end
          end

          # Renaming to a predicate would break the plugin rule API (MAJOR version bump)
          def validate # rubocop:disable Naming/PredicateMethod
            $stdout.puts "Rule#valid? has been deprecated, use \"validate\" in #{self.class.name}"
            valid?
          end

          def self.tags
            [:way_of_working]
          end

          # The ID `audit_github --rule` accepts. Defaults to the feature path, e.g.
          # "versioning/semver". Plugins may override it to give their rules shorter IDs.
          # Part of the plugin API: changing a rule's ID is a breaking change.
          def self.rule_id
            return unless name

            name.delete_prefix('WayOfWorking::').delete_suffix('::GithubAuditRule').underscore
          end

          def tags
            self.class.tags
          end

          private

          def repo_file_contents(path)
            response = @client.contents(@repo_name, path: path)
            Base64.decode64(response.content).force_encoding('UTF-8')
          rescue Octokit::NotFound
            nil
          end

          def repo_file_contains_source_file?(path)
            repo_file_contains?(path, File.read(self.class.source_root.join(path)))
          end

          def repo_file_contains?(path, text)
            remote_content = repo_file_contents(path)
            return false if remote_content.nil?

            remote_content.include?(text)
          end

          # This method returns the content of the README file
          def readme_content
            @readme_content ||=
              begin
                response = @client.readme(@repo_name)

                Base64.decode64(response.content).force_encoding('UTF-8')
              rescue Octokit::NotFound
                ''
              end
          end

          # This convenience method returns the branch rules for this repo
          def branch_rules(branch)
            @client.get("repos/#{@repo.full_name}/rules/branches/#{branch}")
          end
        end
      end
    end
  end
end

# Required after Base is defined: registry -> unknown -> Base would otherwise be
# a circular require when a rule file loads base first.
require_relative 'registry'
