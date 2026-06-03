require 'octokit'
require_relative 'rules/registry'

module WayOfWorking
  module Audit
    module Github
      # This auditor runs all the rules against any given GitHub repository
      class Auditor
        def initialize(access_token, organisation_name, fix = false)
          @access_token = access_token
          @organisation_name = organisation_name
          @fix = fix
        end

        def audit(repository)
          # Get all the rules once, rather than repeatedly in individual rules
          rulesets = @client.get("repos/#{repository.full_name}/rulesets").map do |rule|
            @client.get("repos/#{repository.full_name}/rulesets/#{rule[:id]}")
          end

          Array(Rules::Registry.rules).each do |rule_name, klass|
            rule = klass.new(client, rule_name, repository, rulesets, @fix)

            yield rule
          end
        end

        def repositories
          @repositories ||= client.org_repos(@organisation_name)
        end

        private

        def client
          @client ||= begin
            client = Octokit::Client.new(access_token: @access_token) # , per_page: 1_000
            client.auto_paginate = true
            client
          end
        end
      end
    end
  end
end
