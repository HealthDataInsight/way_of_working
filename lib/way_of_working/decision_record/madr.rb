# frozen_string_literal: true

require_relative 'madr/generators/init'
require_relative 'madr/generators/new'

# If way_of_working-audit-github is used we can add a rule
begin
  require 'way_of_working/audit/github/rules/registry'
  require_relative 'madr/github_audit_rule'
rescue LoadError # rubocop:disable Lint/SuppressedException
end

module WayOfWorking
  module DecisionRecord
    module Madr
      class Error < StandardError; end
    end
  end

  module SubCommands
    # This reopens the "way_of_working init" sub command
    class Init
      register(DecisionRecord::Madr::Generators::Init, 'decision_record', 'decision_record',
               <<~LONGDESC)
                 Description:
                     This generator adds Markdown Any Decision Records (MADR) to your project

                 Example:
                     way_of_working init decision_record

                     This will create:
                         docs/decisions/README.md
                         docs/decisions/adr-template.md
                         docs/decisions/0000-use-markdown-any-decision-records.md
               LONGDESC
    end

    # This reopens the "way_of_working new" sub command
    class New
      register(DecisionRecord::Madr::Generators::New, 'decision_record', 'decision_record [NAME]',
               <<~LONGDESC)
                 Description:
                     This generator adds a new decision record to your project

                 Example:
                     way_of_working new decision_record "Title of the decision"

                     This will create:
                         docs/decisions/NNNN-title-of-the-decision.md
               LONGDESC
    end
  end
end
