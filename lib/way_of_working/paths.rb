# frozen_string_literal: true

require 'pathname'

module WayOfWorking
  # Mixin that provides a couple of pathname convenience methods
  module Paths
    def root
      Pathname.new(File.expand_path('../..', __dir__))
    end

    def source_root
      root.join('lib', 'way_of_working', 'templates')
    end
  end

  extend Paths
end
