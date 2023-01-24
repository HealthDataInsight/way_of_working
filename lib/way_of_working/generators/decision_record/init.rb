# frozen_string_literal: true

require 'way_of_working/paths'

module WayOfWorking
  module Generators
    module DecisionRecord
      # This generator add the MADR files to the doc/decisions folder
      class Init < Thor::Group
        include Thor::Actions

        source_root ::WayOfWorking.source_root

        # Templates are from https://github.com/adr/madr/tree/3.0.0/template
        def create_decision_record_files
          copy_file 'docs/decisions/README.md'

          # from https://raw.githubusercontent.com/adr/madr/3.0.0/template/adr-template.md
          @decision_date = '{YYYY-MM-DD when the decision was last updated}'
          @title = '{short title of solved problem and solution}'
          template 'docs/decisions/adr-template.md'

          get 'https://raw.githubusercontent.com/adr/madr/3.0.0/template/0000-use-markdown-any-decision-records.md',
              'docs/decisions/0000-use-markdown-any-decision-records.md'
        end
      end
    end
  end
end
