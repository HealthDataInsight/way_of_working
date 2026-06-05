# frozen_string_literal: true

require 'thor'

module WayOfWorking
  module PullRequestTemplate
    module Hdi
      module Generators
        # This generator adds the Pull Request template to a project
        class Init < Thor::Group
          include Thor::Actions

          source_root WayOfWorking.root.join('lib', 'way_of_working', 'pull_request_template', 'hdi', 'templates')

          def copy_pr_template_action
            copy_file '.github/pull_request_template.md'
          end

          def copy_way_of_working_documentation
            copy_file 'docs/way_of_working/pull-request-template-and-guidelines.md'
          end
        end
      end
    end
  end
end
