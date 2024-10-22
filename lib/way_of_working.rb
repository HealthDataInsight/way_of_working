# frozen_string_literal: true

require 'way_of_working/cli'
require 'way_of_working/paths'
require 'zeitwerk'

# Require "internal" plugin(s) here
require 'way_of_working/readme_badge'

loader = Zeitwerk::Loader.for_gem
loader.setup

# This is the namespace for everything associated with the Way of Working
module WayOfWorking
  class Error < StandardError; end
end

# Automatically load way_of_working plugins.
Gem::Specification.
  select { |gemspec| gemspec.name =~ /\Away_of_working-/ }.
  collect(&:name).uniq. # multiple versions of a single gem may be installed at once
  each do |name|
  require "#{name.gsub('-', '/')}/plugin"
end
