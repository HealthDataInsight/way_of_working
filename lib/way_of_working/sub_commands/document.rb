# frozen_string_literal: true

require_relative '../generators/linter/document'
require_relative 'base'

module WayOfWorking
  module SubCommands
    # This class defines the "way_of_working document ..." sub command
    class Document < Base
      register(WayOfWorking::Generators::Linter::Document, 'linter', 'linter',
               <<~LONGDESC)
                 Description:
                     This documents the linter on this project

                 Example:
                     way_of_working document linter
               LONGDESC
    end
  end
end
