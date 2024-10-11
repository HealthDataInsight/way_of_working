# frozen_string_literal: true

require 'git'
require 'rainbow'
require 'thor'

module WayOfWorking
  module Generators
    module Github
      # This generator runs the github audit
      class Audit < Thor::Group
        # argument :all_repos, type: :string, required: false, desc: 'Optional repo to test'

        desc 'This runs the github audit on this project'

        def run_first
          @start_time = Time.now

          git_base = ::Git.open('.')
          remotes = git_base.remotes.map(&:url)
          @github_remotes = remotes.select { |url| url.start_with?('https://github.com/') }

          abort(Rainbow("\nGitHub is not an upstream repository!").red) if @github_remotes.empty?

          # say(Rainbow("Limiting audit to #{path}\n").yellow) if path
          say "\nRunning..."
        end

        def prep_and_run_alex
          @github_remotes.each do |url|
            matchdata = url.match(%r{\Ahttps://github.com/([^/]+)/([^/]+)\.git})

            organisation = matchdata[1]
            repo_name = matchdata[2]

            say(Rainbow("\nRepo: #{organisation}/#{repo_name}").yellow)
          end

          @audit_ok = true
        end

        def run_last
          say(Rainbow("\nTotal time taken: #{(Time.now - @start_time).to_i} seconds").yellow)

          if @audit_ok
            say(Rainbow("\nGitHub audit succeeded!").green)
          else
            abort(Rainbow("\nGitHub audit failed!").red)
          end
        end

        private

        def run_alex(arguments)
          system(*arguments)
        end
      end
    end
  end
end
