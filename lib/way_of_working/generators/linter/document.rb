# frozen_string_literal: true

require 'active_support/core_ext/string'
require 'nokogiri'
require 'open-uri'
require 'thor'
require 'way_of_working/paths'

module WayOfWorking
  module Generators
    module Linter
      # Struct to hold linter data
      class SupportedLinter
        # Reasons why certain linters are not used
        NOT_USED_REASON = {
          'CSS_SCSS_LINT' => 'scss-lint recommends using stylelint',
          'HTML_DJLINT' => 'Refuses to see config file',
          'RUBY_RUBOCOP' => 'RuboCop is used directly'
        }.freeze

        # Acronyms for languages
        TLA_LANGUAGES = %w[
          CSS
          ENV
          HTML
          JSON
          JSX
          PHP
          SQL
          TSX
          XML
          YAML
        ].freeze

        # Mapping for languages
        LANGUAGE_MAPPINGS = {
          'Action' => 'GitHub Action',
          'Arm' => 'ARM Templates',
          'Cloudformation' => 'CloudFormation',
          'Coffee' => 'CoffeeScript',
          'Editorconfig' => 'EditorConfig',
          'Graphql' => 'GraphQL',
          'Javascript' => 'JavaScript',
          'Latex' => 'LaTeX',
          'Protobuf' => 'Protocol Buffers',
          'Rst' => 'reStructuredText',
          'Spell' => 'Spelling',
          'Typescript' => 'TypeScript',
          'Visual Basic .Net' => 'VB.Net'
        }.freeze

        attr_accessor :name, :link, :enabled_linters, :sorter

        def initialize(language, constant_name, name, link, enabled_linters)
          @original_language = language
          @original_constant_name = constant_name
          @name = name
          @link = link
          @enabled_linters = enabled_linters

          # Array used for sorting
          @sorter = [@original_language, @original_constant_name]
        end

        def language
          language = @original_language

          # Titleize language unless it is an acronym
          language = language.titleize unless TLA_LANGUAGES.include?(language)

          # Use mapped language name if available
          language = LANGUAGE_MAPPINGS[language] if LANGUAGE_MAPPINGS.key?(language)

          language
        end

        def constant_name
          return @original_constant_name if enabled_linters.include?(@original_constant_name)

          # Strike-through the constant name if the linter is not used
          "~~#{@original_constant_name}~~"
        end

        def details
          return "[#{name}](#{link})" if enabled_linters.include?(@original_constant_name)

          details = 'Not Used'

          # Add reason if available
          if NOT_USED_REASON.key?(@original_constant_name)
            details = "#{details} (#{NOT_USED_REASON[@original_constant_name]})"
          end

          details
        end
      end

      # This class is responsible for generating linter documentation
      class Document < Thor::Group
        include Thor::Actions # Mixin for action methods provided by Thor

        # Set the source root for the templates
        source_root ::WayOfWorking.source_root

        # URL of the supported linters
        SUPPORTED_LINTERS_URL = 'https://megalinter.io/latest/supported-linters/'

        # Method to prepare the list of linters from the supported linters URL
        def prepare_linter_lists
          # Initialize an empty hash for linter types
          @types = {}

          # Iterate over each linter type in the parsed HTML
          parse_linter_types_html do |type, html_rows|
            @types[type] = []

            parse_linter_rows(html_rows) do |constant_name, language, name, link|
              # Create a new linter object and add it to the list
              @types[type] << SupportedLinter.new(language, constant_name, name, link,
                                                  enabled_linters)
            end
          end
        end

        # Method to create the linter documentation using a template
        def create_linters_documentation
          template 'docs/code-linting/linters.md'
        end

        private

        def parse_linter_types_html
          # Parse HTML from the supported linters URL
          doc = Nokogiri::HTML(URI.parse(SUPPORTED_LINTERS_URL).read)

          doc.css('article h2').each do |h2|
            type = h2.text.strip

            yield type, h2.next_element.css('tbody tr')
          end
        end

        def parse_linter_rows(html_rows)
          # Iterate over each linter in the current type
          html_rows.each do |tr|
            tds = tr.css('td')
            constant_name = tds[2].css('a')[1].text
            language = tds[1].text.sub(/\s\([^)]+\)\z/, '')
            name = tds[2].css('a')[0].text
            link = tds[2].css('a')[0].attributes['href'].value.sub(/\A\.\./, 'https://megalinter.io/latest')

            yield constant_name, language, name, link
          end
        end

        # Load enabled linters from the YAML config file
        def enabled_linters
          @enabled_linters ||= YAML.load_file('.mega-linter.yml')['ENABLE_LINTERS']
        end
      end
    end
  end
end
