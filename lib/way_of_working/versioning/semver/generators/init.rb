# frozen_string_literal: true

module WayOfWorking
  module Versioning
    module Semver
      module Generators
        # This generator add the Semver files to the doc/decisions folder
        class Init < Thor::Group
          include Thor::Actions

          source_root WayOfWorking.root.join('lib', 'way_of_working', 'versioning', 'semver', 'templates')

          def copy_way_of_working_file
            copy_file 'docs/way_of_working/versioning.md'
          end
        end
      end
    end
  end
end
