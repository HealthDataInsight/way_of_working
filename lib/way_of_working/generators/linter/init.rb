# frozen_string_literal: true

require 'thor'
require 'way_of_working/paths'

module WayOfWorking
  module Generators
    module Linter
      # This generator initialises the linter
      class Init < Thor::Group
        include Thor::Actions

        source_root ::WayOfWorking.source_root

        LINTING_BUILD_PHASE =
          "				2F0882F42AAB152D00DB0B2B /* ShellScript */,\n"
        LINTING_BUILD_PHASE_DETAILS = <<~CONFIG
          /* Begin PBXShellScriptBuildPhase section */
          \t\t2F0882F42AAB152D00DB0B2B /* ShellScript */ = {
          \t\t\tisa = PBXShellScriptBuildPhase;
          \t\t\tbuildActionMask = 2147483647;
          \t\t\tfiles = (
          \t\t\t);
          \t\t\tinputFileListPaths = (
          \t\t\t);
          \t\t\tinputPaths = (
          \t\t\t);
          \t\t\toutputFileListPaths = (
          \t\t\t);
          \t\t\toutputPaths = (
          \t\t\t);
          \t\t\trunOnlyForDeploymentPostprocessing = 0;
          \t\t\tshellPath = /bin/sh;
          \t\t\tshellScript = "if [[ \\"$(uname -m)\\" == arm64 ]]; then\\n    export PATH=\\"/opt/homebrew/bin:$PATH\\"\\nfi\\n\\nif which swiftlint > /dev/null; then\\n  swiftlint\\nelse\\n  echo \\"warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint\\"\\nfi\\n";
          \t\t};
          /* End PBXShellScriptBuildPhase section */

        CONFIG

        # TODO: copy_rubocop_github_workflow_action

        def copy_github_linters_rubocop_config_file
          copy_file '.github/linters/rubocop_defaults.yml'
        end

        def copy_github_linters_markdown_link_check_config_file
          copy_file '.github/linters/.markdown-link-check.json'
        end

        def copy_megalinter_github_workflow_action
          copy_file '.github/workflows/mega-linter.yml'
        end

        def copy_megalinter_dot_file
          copy_file '.mega-linter.yml'
        end

        def create_gitignore_if_missing
          create_file_if_missing '.gitignore'
        end

        def gitignore_reports_folder
          append_to_file '.gitignore', "megalinter-reports/\n"
        end

        def gitignore_rubocop_cached_file
          append_to_file '.gitignore', ".rubocop-https---*\n"
        end

        def copy_rubocop_options_file
          copy_file '.rubocop'
        end

        def inject_swiftlint_into_xcode_project_build_process
          return unless xcode_project_file && File.exist?(xcode_project_file)

          inject_into_file xcode_project_file,
                           LINTING_BUILD_PHASE,
                           after: "buildPhases = (\n"

          inject_into_file xcode_project_file,
                           LINTING_BUILD_PHASE_DETAILS,
                           after: "/* End PBXResourcesBuildPhase section */\n\n"
        end

        private

        def xcode_project_file
          puts Dir.glob(File.join(destination_root)).inspect
          Dir.glob(File.join(destination_root, '*.xcodeproj/project.pbxproj')).first
        end

        def create_file_if_missing(path)
          path = File.join(destination_root, path)
          return if behavior == :revoke || File.exist?(path)

          File.open(path, 'w', &:write)
        end
      end
    end
  end
end
