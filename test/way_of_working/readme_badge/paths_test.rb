# frozen_string_literal: true

require 'test_helper'

module WayOfWorking
  module ReadmeBadge
    class PathsTest < Minitest::Test
      def setup
        @gem_root = Pathname.new(File.expand_path('../../..', __dir__))
      end

      def test_paths_module_is_defined
        assert_kind_of Module, WayOfWorking::ReadmeBadge::Paths
      end

      def test_root_returns_gem_root_pathname
        assert_equal @gem_root, WayOfWorking::ReadmeBadge.root
      end

      def test_source_root_points_at_templates_directory
        expected = @gem_root.join('lib', 'way_of_working', 'readme_badge', 'templates')
        assert_equal expected, WayOfWorking::ReadmeBadge.source_root
      end

      def test_source_root_directory_exists
        assert WayOfWorking::ReadmeBadge.source_root.directory?,
               "Expected #{WayOfWorking::ReadmeBadge.source_root} to exist on disk"
      end
    end
  end
end
