# frozen_string_literal: true

require_relative 'base'
require_relative '../config'

module WayOfWorking
  module SubCommands
    # This class defines the "config" parent command, for persisting values (like a
    # code of conduct contact method) in ~/.config/way_of_working/config.yaml so
    # they don't need to be passed as CLI options every time
    class Config < Base
      desc 'get [KEY]', 'Reads a value from the way_of_working config file'
      def get(key)
        value = ::WayOfWorking::Config.get(key)
        say(value.nil? ? "#{key} is not set" : value.to_s)
      end

      desc 'set [KEY] [VALUE]', 'Writes a value to the way_of_working config file'
      def set(key, value)
        ::WayOfWorking::Config.set(key, value)
        say "Saved #{key} to #{::WayOfWorking::Config.path}"
      end
    end
  end
end
