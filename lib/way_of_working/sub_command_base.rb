# frozen_string_literal: true

require 'thor'

# This class enables subcommands to work correctly with help. See:
# https://github.com/rails/thor/wiki/Subcommands#subcommands-that-work-correctly-with-help
class SubCommandBase < Thor
  def self.banner(command, _namespace = nil, _subcommand: false)
    "#{basename} #{subcommand_prefix} #{command.usage}"
  end

  def self.subcommand_prefix
    name.gsub(/.*::/, '').gsub(/^[A-Z]/) { |match| match[0].downcase }.
      gsub(/[A-Z]/) { |match| "-#{match[0].downcase}" }
  end
end
