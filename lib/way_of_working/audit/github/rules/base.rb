# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext'
require 'base64'
require 'octokit'
require_relative 'registry'

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

          def validate
            $stdout.puts "Rule#valid? has been deprecated, use \"validate\" in #{self.class.name}"
            valid?
          end

          def self.tags
            [:way_of_working]
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
