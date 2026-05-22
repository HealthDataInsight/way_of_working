# frozen_string_literal: true

require 'test_helper'

module WayOfWorking
  # Eager-loads the gem's own Zeitwerk loader to guarantee every file under
  # lib/ defines the constant Zeitwerk expects. Catches file/constant drift
  # like the tasks.rb, readme_badge/paths.rb, and github_audit_rule.rb
  # regressions.
  class ZeitwerkGemLoaderTest < Minitest::Test
    def test_gem_eager_load
      lib_dir = File.expand_path('../../lib', __dir__)
      gem_loader = Zeitwerk::Registry.loaders.find do |loader|
        loader.dirs.any? { |dir| File.expand_path(dir) == lib_dir }
      end

      refute_nil gem_loader, "Could not find Zeitwerk loader for #{lib_dir}"

      gem_loader.eager_load(force: true)
    rescue Zeitwerk::NameError => e
      flunk "Eager loading the gem failed with error: #{e.message}"
    else
      assert true
    end
  end
end
