# frozen_string_literal: true

require 'thor'
require_relative 'way_of_working/cli'
require_relative 'way_of_working/paths'
require_relative 'way_of_working/version'

module WayOfWorking
  class Error < StandardError; end
end

# Magically load way_of_working plugins.
Gem::Specification.
  select { |gemspec| gemspec.name =~ /\Away_of_working-/ }.
  collect(&:name).uniq. # multiple versions of a single gem may be installed at once
  each do |name|
  require "#{name.gsub('-', '/')}/plugin"
rescue LoadError
  warn(Rainbow("Failed to load #{name} plugin.\n").red)
end
