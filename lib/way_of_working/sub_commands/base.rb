# frozen_string_literal: true

require 'thor'

module WayOfWorking
  module SubCommands
    # This base class enables subcommands to work correctly with help. See:
    # https://github.com/rails/thor/wiki/Subcommands#subcommands-that-work-correctly-with-help
    class Base < Thor
      def self.banner(command, _namespace = nil, _subcommand = false)
        "#{basename} #{subcommand_prefix} #{command.usage}"
      end

      # Thor's register doesn't copy a Thor::Group's class_options onto the
      # wrapper command, so they're missing from help. See:
      # https://github.com/rails/thor/issues/661
      def self.register(klass, subcommand_name, usage, description, options = {})
        super
        commands[subcommand_name].options = klass.class_options if klass <= Thor::Group
      end

      def self.subcommand_prefix
        name.gsub(/.*::/, '').gsub(/^[A-Z]/) { |match| match[0].downcase }.
          gsub(/[A-Z]/) { |match| "-#{match[0].downcase}" }
      end
    end
  end
end
