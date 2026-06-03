# frozen_string_literal: true

module WayOfWorking
  module DecisionRecord
    module Madr
      module Generators
        # This generator add the MADR files to the doc/decisions folder
        class Init < Thor::Group
          include Thor::Actions

          source_root WayOfWorking.root.join('lib', 'way_of_working', 'decision_record', 'madr', 'templates')

          def copy_decision_record_issue_template
            copy_file '.github/ISSUE_TEMPLATE/decision-record.md'
          end

          # Templates are from https://github.com/adr/madr/tree/3.0.0/template
          def create_decision_record_files
            copy_file 'docs/decisions/README.md'

            # from https://raw.githubusercontent.com/adr/madr/3.0.0/template/adr-template.md
            @decision_date = '{YYYY-MM-DD when the decision was last updated}'
            @index = '{index}'
            @title = '{short title of solved problem and solution}'
            template 'docs/decisions/adr-template.md'

            copy_file 'docs/decisions/0000-use-markdown-any-decision-records.md'
          end

          def copy_index_file
            copy_file 'docs/decisions/index.md'
          end

          def copy_way_of_working_file
            copy_file 'docs/way_of_working/decision-records.md'
          end
        end
      end
    end
  end
end
