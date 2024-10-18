# frozen_string_literal: true

require 'thor'

require_relative 'sub_commands/exec'
require_relative 'sub_commands/init'
require_relative 'sub_commands/new'

module WayOfWorking
  # This class defines the top level interface
  class Cli < Thor
    desc 'exec [COMPONENT]', 'Executes (runs) the specific component'
    subcommand 'exec', ::WayOfWorking::SubCommands::Exec

    desc 'init [COMPONENT]', 'Initialises Way of Working components'
    subcommand 'init', ::WayOfWorking::SubCommands::Init

    desc 'new [THING]', 'Creates new things'
    subcommand 'new', ::WayOfWorking::SubCommands::New
  end
end
