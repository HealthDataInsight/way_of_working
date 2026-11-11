# frozen_string_literal: true

# Loads the v2.1 feature (generator, audit rule and `init code_of_conduct` command); the v3 feature
# re-registers the command afterwards, so v3 wins whenever it is required.
require 'way_of_working/code_of_conduct/contributor_covenant'

module WayOfWorking
  module CodeOfConduct
    module ContributorCovenantV3
      module Generators
        # Generates the Contributor Covenant v3 code of conduct. It behaves exactly like the v2.1
        # generator (contact method handling, config fallback), only the templates differ.
        class Init < ContributorCovenant::Generators::Init
          source_root WayOfWorking.root.join('lib', 'way_of_working', 'code_of_conduct', 'contributor_covenant_v3',
                                             'templates')
        end
      end
    end
  end
end
