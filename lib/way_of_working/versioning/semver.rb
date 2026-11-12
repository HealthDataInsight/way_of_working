# frozen_string_literal: true

require_relative 'semver/generators/init'

# Register the GitHub audit rule (the registry is bundled with this gem)
require_relative 'semver/github_audit_rule'

module WayOfWorking
  module Versioning
    module Semver
      class Error < StandardError; end
    end
  end

  module SubCommands
    # This reopens the "way_of_working init" sub command
    class Init
      register(Versioning::Semver::Generators::Init, 'versioning', 'versioning',
               <<~LONGDESC)
                 Description:
                     This generator adds Semantic Versioning to your project

                 Example:
                     way_of_working init versioning

                     This will create:
                         docs/way_of_working/versioning.md
               LONGDESC
    end
  end
end
