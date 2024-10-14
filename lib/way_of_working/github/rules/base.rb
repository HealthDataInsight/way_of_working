# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext'
require 'base64'
require 'octokit'
require_relative 'registry'

module WayOfWorking
  module Github
    module Rules
      # This is the base class for design system adapters
      class Base
        attr_accessor :errors, :name, :rulesets, :warnings

        def initialize(client, name, repo, rulesets)
          @client = client
          @name = name
          @repo = repo
          @repo_name = repo.full_name
          @rulesets = rulesets
          @errors = []
          @warnings = []
        end

        def status
          @status ||= valid?
        end

        def tags
          [:way_of_working]
        end

        private

        def readme_content
          @readme_content ||=
            begin
              response = @client.readme(@repo_name)

              Base64.decode64(response.content)
            rescue Octokit::NotFound
              ''
            end
        end

        def branch_rules(branch)
          @client.get("repos/#{@repo.full_name}/rules/branches/#{branch}")
        end
      end
    end
  end
end
