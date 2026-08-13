# frozen_string_literal: true

require 'way_of_working/paths'
require 'way_of_working/config'

module WayOfWorking
  module CodeOfConduct
    module ContributorCovenant
      module Generators
        # This class fetches the CODE_OF_CONDUCT.md and inserts the contact method
        class Init < Thor::Group
          include Thor::Actions

          CONTACT_METHOD_CONFIG_KEY = 'code_of_conduct.contact_method'

          source_root WayOfWorking.root.join('lib', 'way_of_working', 'code_of_conduct', 'contributor_covenant',
                                             'templates')

          class_option :contact_method

          # Use this method to update the cached template when required
          # def download_and_save_code_of_conduct_template
          #   code_of_conduct_file = 'lib/way_of_working/templates/CODE_OF_CONDUCT.md.tt'

          #   get 'https://www.contributor-covenant.org/version/2/1/code_of_conduct/code_of_conduct.md',
          #       code_of_conduct_file
          #   gsub_file code_of_conduct_file, '[INSERT CONTACT METHOD]',
          #             "<<%= contact_method %>>"
          # end

          def add_code_of_conduct_to_project
            contact_method
            offer_to_remember_contact_method
            template 'CODE_OF_CONDUCT.md'
          end

          def add_way_of_working_documentation
            copy_file 'docs/way_of_working/code-of-conduct.md'
          end

          private

          # The contact method comes from --contact-method, falling back to the value
          # stored under CONTACT_METHOD_CONFIG_KEY in way_of_working's config file (see
          # `way_of_working config`), read fresh on every call rather than cached in the
          # class_option default so config changes are picked up within a single process
          # (e.g. across tests, or repeated invocations in bin/console).
          def contact_method
            @contact_method ||= options['contact_method'] || ::WayOfWorking::Config.get(CONTACT_METHOD_CONFIG_KEY)
            @contact_method ||= raise(Thor::Error, 'No contact method provided. Pass --contact-method, or set a ' \
                                                   'default with `way_of_working config set ' \
                                                   "#{CONTACT_METHOD_CONFIG_KEY} you@example.com`")
          end

          def offer_to_remember_contact_method
            return unless options['contact_method']
            return if options['contact_method'] == ::WayOfWorking::Config.get(CONTACT_METHOD_CONFIG_KEY)

            question = "Remember '#{options['contact_method']}' as your code of conduct contact method " \
                       'for next time? (y/n)'
            return unless yes?(question)

            ::WayOfWorking::Config.set(CONTACT_METHOD_CONFIG_KEY, options['contact_method'])
          end
        end
      end
    end
  end
end
