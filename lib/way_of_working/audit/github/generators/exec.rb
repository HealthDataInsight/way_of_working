# frozen_string_literal: true

require 'git'
require 'rainbow'
require 'thor'
require 'way_of_working/audit/github/auditor'
# require 'way_of_working/github_audit/rules/all'

module WayOfWorking
  module Audit
    module Github
      module Generators
        # This generator runs the github audit
        class Exec < Thor::Group
          class_option :all, type: :boolean, default: false,
                             desc: 'Audit all repositories in the organisation (not just this repo)'

          class_option :fix, type: :boolean, default: false,
                             desc: 'Attempt to automatically fix issues where possible'

          class_option :name, type: :array, default: nil,
                              desc: 'Filter repositories by name (e.g., structured_store)'

          class_option :public, type: :boolean, default: false,
                                desc: 'Filter to only public repositories'

          class_option :topic, type: :string, default: nil,
                               desc: 'Filter repositories by topic (e.g., way-of-working)'

          desc 'This runs the github audit on this project'

          def check_for_github_token_environment_variables
            @github_token = ENV.fetch('GITHUB_TOKEN', nil)
            return unless @github_token.nil?

            abort(Rainbow("\nMissing GITHUB_TOKEN environment variable").red)
          end

          def check_for_github_organisation_environment_variables
            @github_organisation = ENV.fetch('GITHUB_ORGANISATION', nil)
            return unless @github_organisation.nil?

            abort(Rainbow("\nMissing GITHUB_ORGANISATION environment variable").red)
          end

          def start_timer
            @start_time = Time.now
          end

          def check_github_organisation_remotes
            abort(Rainbow("\nGitHub is not an upstream repository.").red) if github_organisation_remotes.empty?

            # say("Limiting audit to #{path}\n", :yellow) if path
            say "\nRunning..."
          end

          def prep_audit
            @auditor = ::WayOfWorking::Audit::Github::Auditor.new(@github_token, @github_organisation, options[:fix])

            # Loop though all the repos
            @repositories = @auditor.repositories
          rescue Octokit::Unauthorized
            abort(Rainbow("\nGITHUB_TOKEN has expired or does not have sufficient permission").red)
          end

          def filter_all_if_specified
            return if options[:all] || options[:name]

            @repositories = @repositories.select do |repo|
              github_organisation_remotes.include?(repo.name)
            end
          end

          def filter_by_name_array_if_specified
            return unless options[:name]

            @repositories = @repositories.select do |repo|
              options[:name].include?(repo.name)
            end
          end

          def filter_by_topic_if_specified
            return unless options[:topic]

            @repositories = @repositories.select do |repo|
              repo.topics.include?(options[:topic])
            end
          end

          def filter_by_visibility_if_specified
            return unless options[:public]

            @repositories = @repositories.reject(&:private?)
          end

          def run_audit
            @audit_ok = true
            unarchived_repos.each do |repo|
              @auditor.audit(repo) do |rule|
                case rule.status
                when :not_applicable
                  # Do nothing
                when :passed
                  say "  ✅ #{rule.tags.inspect} Passed #{rule.name}"
                when :failed
                  say "  ❌ #{rule.tags.inspect} Failed #{rule.name}: #{rule.errors.to_sentence}"
                  @audit_ok = false
                else
                  abort(Rainbow("Unknown response #{rule.status.inspect}").red)
                end
              end
            end
          end

          def run_last
            say("\nTotal time taken: #{(Time.now - @start_time).to_i} seconds", :yellow)

            if @audit_ok
              say("\nGitHub audit succeeded!", :green)
            else
              abort(Rainbow("\nGitHub audit failed!").red)
            end
          end

          private

          def unarchived_repos(&block)
            return to_enum(__method__) unless block_given?

            @repositories.each do |repo|
              next if repo.archived?

              say
              say("#{repo.name} #{repo.private? ? '🔒' : ''}", :bold)
              say("#{repo.description} [#{repo.language}]")
              say(repo.topics.join(' '), :cyan) unless repo.topics.empty?

              block.call(repo)
            end
          end

          # This method returns the repo names for all upstream repositories
          # hosted on GitHub, for the given organisation
          def github_organisation_remotes
            @github_organisation_remotes ||= begin
              all_remote_urls = ::Git.open('.').remotes.map(&:url)

              organisation_remote_urls = all_remote_urls.select do |url|
                url.start_with?("https://github.com/#{@github_organisation}")
              end

              organisation_remote_urls.map do |url|
                matchdata = url.match(%r{\Ahttps://github.com/([^/]+)/([^/]+)\.git})

                matchdata[2]
              end
            end
          end
        end
      end
    end
  end
end
