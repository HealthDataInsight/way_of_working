# frozen_string_literal: true

require 'open3'
require 'test_helper'

module WayOfWorking
  # Tests the shell completion candidates and scripts
  class CompletionTest < Minitest::Test
    def test_top_level_commands
      assert_includes Completion.candidates(['']), 'init'
      assert_includes Completion.candidates(['']), 'completion'
      assert_equal ['init'], Completion.candidates(['in'])
    end

    def test_subcommand_commands
      assert_includes Completion.candidates(['init', '']), 'all'
      assert_includes Completion.candidates(['init', '']), 'readme_badge'
    end

    def test_options_once_a_command_is_typed
      assert_equal ['--contact-method'], Completion.candidates(['init', 'all', ''])
      assert_equal ['--contact-method'], Completion.candidates(%w[init all --contact-method x --c])
    end

    def test_unknown_words_give_no_candidates
      assert_empty Completion.candidates(['nope', ''])
      assert_empty Completion.candidates(['init', 'nope', ''])
    end

    def test_scripts
      assert_includes Completion.script('bash'), 'complete -F _way_of_working way_of_working'
      assert_includes Completion.script('zsh'), 'compdef _way_of_working way_of_working'
      assert_raises(Thor::Error) { Completion.script('fish') }
    end

    def test_executable_handles_complete
      exe = File.expand_path('../../exe/way_of_working', __dir__)
      lib = File.expand_path('../../lib', __dir__)
      out, status = Open3.capture2e(RbConfig.ruby, '-I', lib, exe, '__complete', 'init', 'a')

      assert status.success?, out
      assert_equal "all\n", out
    end
  end
end
