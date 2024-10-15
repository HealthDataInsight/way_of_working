# frozen_string_literal: true

require 'thor'

require_relative 'cli/sub_commands/document'
require_relative 'cli/sub_commands/exec'
require_relative 'cli/sub_commands/init'
require_relative 'cli/sub_commands/new'

module WayOfWorking
  # This class defines the top level interface
  class Cli < Thor
    desc 'init [COMPONENT]', 'Initialises Way of Working components'
    subcommand 'init', SubCommands::Init

    desc 'new [THING]', 'Creates new things'
    subcommand 'new', SubCommands::New

    desc 'exec [COMPONENT]', 'Executes (runs) the specific component'
    subcommand 'exec', SubCommands::Exec

    desc 'document [COMPONENT]', 'Documents the specific component'
    subcommand 'document', SubCommands::Document
  end
end
