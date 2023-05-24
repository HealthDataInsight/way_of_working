# frozen_string_literal: true

require 'thor'
require 'way_of_working/paths'

module WayOfWorking
  module Generators
    module PrTemplate
      # This generator adds the Pull Request template to a project
      class Init < Thor::Group
        include Thor::Actions

        source_root ::WayOfWorking.source_root

        def copy_pr_template_action
          copy_file '.github/pull_request_template.md'
        end
      end
    end
  end
end
