# frozen_string_literal: true

require 'date'
require 'way_of_working/paths'

module WayOfWorking
  module Generators
    module DecisionRecord
      # This generator add a new MADR decision record to the doc/decisions folder
      class New < Thor::Group
        argument :name, type: :string, required: true, desc: 'The title of the decision record'

        include Thor::Actions

        source_root ::WayOfWorking.source_root

        def create_decision_record_file
          case behavior
          when :invoke
            invoke_decision_record_file
          when :revoke
            revoke_decision_record_file
          end
        end

        private

        def invoke_decision_record_file
          @decision_date = Date.today.strftime('%Y-%m-%d')
          @title = name

          # from https://raw.githubusercontent.com/adr/madr/3.0.0/template/adr-template.md
          template 'docs/decisions/adr-template.md',
                   "docs/decisions/#{next_decision_number}-#{dashed_name}.md"
        end

        def revoke_decision_record_file
          matching_files = Dir.glob("[0-9][0-9][0-9][0-9]-#{dashed_name}.md",
                                    base: File.join(destination_root, 'docs/decisions'))
          raise "No matching decision record for '#{dashed_name}'" if matching_files.empty?

          # based on Thor's remove_file
          path = File.expand_path("docs/decisions/#{matching_files.first}", destination_root)

          say_status :remove, relative_to_original_destination_root(path)
          return unless !options[:pretend] && (File.exist?(path) || File.symlink?(path))

          require 'fileutils'
          ::FileUtils.rm_rf(path)
        end

        def next_decision_number
          existing_decisions = Dir.glob('[0-9][0-9][0-9][0-9]-*.md',
                                        base: File.join(destination_root, 'docs/decisions'))
          last_number = existing_decisions.map do |filename|
            filename.match(/\A(\d{4})-/)[1].to_i
          end.max || -1
          format('%04d', last_number + 1)
        end

        def dashed_name
          name.downcase.gsub(/[\s_]/, '-').gsub(/-+/, '-')
        end
      end
    end
  end
end
