# frozen_string_literal: true

require 'thor'
require_relative 'way_of_working/cli'
require_relative 'way_of_working/paths'
require_relative 'way_of_working/version'

module WayOfWorking
  class Error < StandardError; end
end
