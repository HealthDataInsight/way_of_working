# frozen_string_literal: true

require 'yaml'
require 'pathname'

module WayOfWorking
  # Reads and writes ~/.config/way_of_working/config.yaml (or
  # $XDG_CONFIG_HOME/way_of_working/config.yaml), so values like a code of
  # conduct contact method can be set once and reused across CLI invocations
  # instead of being passed as an option every time. Keys are dotted paths
  # namespaced by feature (e.g. "code_of_conduct.contact_method") so future
  # features (e.g. a security contact) can coexist.
  module Config
    class << self
      def path
        Pathname.new(ENV.fetch('XDG_CONFIG_HOME', File.join(Dir.home, '.config'))).
          join('way_of_working', 'config.yaml')
      end

      def get(dotted_key)
        dotted_key.to_s.split('.').reduce(load_file) { |node, key| node.is_a?(Hash) ? node[key] : nil }
      end

      def set(dotted_key, value)
        keys = dotted_key.to_s.split('.')
        data = load_file
        keys[0..-2].reduce(data) { |node, key| node[key] ||= {} }[keys[-1]] = value
        save_file(data)
      end

      private

      def load_file
        return {} unless path.exist?

        YAML.load_file(path) || {}
      end

      def save_file(data)
        path.dirname.mkpath
        path.write(YAML.dump(data))
      end
    end
  end
end
