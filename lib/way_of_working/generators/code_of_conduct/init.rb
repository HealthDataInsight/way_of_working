# frozen_string_literal: true

require 'way_of_working/paths'

module WayOfWorking
  module Generators
    module CodeOfConduct
      # This class fetches the CODE_OF_CONDUCT.md and inserts the contact method
      class Init < Thor::Group
        include Thor::Actions

        source_root ::WayOfWorking.source_root

        class_option :contact_method, required: true

        # Use this method to update the cached template when required
        # def download_and_save_code_of_conduct_template
        #   code_of_conduct_file = 'lib/way_of_working/templates/CODE_OF_CONDUCT.md.tt'

        #   get 'https://www.contributor-covenant.org/version/2/1/code_of_conduct/code_of_conduct.md',
        #       code_of_conduct_file
        #   gsub_file code_of_conduct_file, '[INSERT CONTACT METHOD]',
        #             "<%= options['contact_method'] %>"
        # end

        def add_code_of_conduct_to_project
          template 'CODE_OF_CONDUCT.md'
        end
      end
    end
  end
end
