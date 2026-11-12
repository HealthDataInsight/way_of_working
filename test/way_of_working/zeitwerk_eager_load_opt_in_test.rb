# frozen_string_literal: true

require 'test_helper'
require 'open3'
require 'rbconfig'

module WayOfWorking
  # Eager loading must not enable opt-in built-in features. Runs in a fresh
  # process because other tests explicitly require some of those features.
  class ZeitwerkEagerLoadOptInTest < Minitest::Test
    SCRIPT = <<~RUBY
      require 'way_of_working'
      lib_dir = File.expand_path('lib')
      Zeitwerk::Registry.loaders.find { |l| l.dirs.include?(lib_dir) }.eager_load(force: true)
      # Implicit namespaces still resolve without their entrypoints
      WayOfWorking::Changelog::Keepachangelog::Generators::Init
      WayOfWorking::DecisionRecord::Madr::Generators::New
      WayOfWorking::InclusiveLanguage::Alex::Generators::Exec
      sub_commands = WayOfWorking::SubCommands
      puts [sub_commands::Init, sub_commands::New, sub_commands::Exec].flat_map { |c| c.commands.keys }.sort.uniq
    RUBY

    def test_eager_load_leaves_opt_in_features_dormant
      out, err, status = Open3.capture3(RbConfig.ruby, '-Ilib', '-e', SCRIPT,
                                        chdir: File.expand_path('../..', __dir__))

      assert status.success?, err
      assert_equal %w[all help readme_badge], out.split
    end
  end
end
