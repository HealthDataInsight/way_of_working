# frozen_string_literal: true

require 'way_of_working/github/rules/cis_benchmark/base'

module WayOfWorking
  module Github
    # This is the namespace for GitHub rules
    module Rules
      module CisBenchmark
        module SourceCode
          module RepositoryManagement
            # This rule checks all public repositories contain a SECURITY.md file.
            class PublicSecurityFile < ::WayOfWorking::Github::Rules::CisBenchmark::Base
              def tags
                super << :cis_level1
              end

              def valid?
                return :not_applicable if @repo.private?

                begin
                  @client.contents(@repo_name, path: 'SECURITY.md')
                rescue Octokit::NotFound
                  @errors << 'All public repositories must contain a SECURITY.md file.'
                end

                @errors.empty? ? :passed : :failed
              end
            end
          end
        end
      end

      Registry.register(CisBenchmark::SourceCode::RepositoryManagement::PublicSecurityFile,
                        'Public SECURITY.md File')
    end
  end
end
