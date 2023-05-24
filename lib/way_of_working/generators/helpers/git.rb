require 'way_of_working/git/repo_reader'

module WayOfWorking
  module Generators
    module Helpers
      # Git helper methods for generators
      module Git
        private

        def repo_reader
          @repo_reader ||= ::WayOfWorking::Git::RepoReader.new(::Git.open('.'))
        end

        def summary_tags
          @summary_tags ||= repo_reader.summary_tags.reverse
        end

        def url
          @url ||= repo_reader.likely_upstream_remote_url
        end
      end
    end
  end
end
