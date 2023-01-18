# frozen_string_literal: true

# Mixin that provides a couple of pathname convenience methods
module WayOfWorking
  class << self
    def root
      Pathname.new(File.expand_path('../..', __dir__))
    end

    def source_root
      root.join('lib', 'way_of_working', 'templates')
    end
  end
end
