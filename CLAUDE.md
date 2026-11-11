# CLAUDE.md

## Commands

- `bin/setup` to install dependencies
- `bundle exec rake test` to run all tests
- `bundle exec ruby -Ilib -Itest test/way_of_working/decision_record/madr/generators/init_test.rb` to test one file
- `bundle exec ruby -Ilib -Itest test/path/to/file_test.rb -n "/files_are_created/"` to run on one test (names use underscores)
- `bundle exec rake rubocop` to lint Ruby
- `bundle exec exe/way_of_working help` to run the CLI from source

## Architecture

`way_of_working` is a Thor CLI (`exe/way_of_working` → `WayOfWorking::Cli`) with four subcommands: `init`, `new`, `exec` and `config`. Each is a `Thor` class in `lib/way_of_working/sub_commands/`. Features add commands by reopening those classes and calling `register(GeneratorClass, name, usage, long_desc)`. `SubCommands::Base.register` copies a `Thor::Group`'s `class_options` onto the wrapper command so they show in `--help`.

**Features** follow a `category/variant` namespace (`decision_record/madr`, `code_of_conduct/contributor_covenant`). Each has:
- `<variant>.rb`: requires its generators, registers them with the subcommands and, if the audit feature is loaded, requires its audit rule inside `begin … rescue LoadError`.
- `<variant>/generators/*.rb`: `Thor::Group` + `Thor::Actions` generators whose `source_root` is `<variant>/templates/`. The templates mirror the target project's layout, and files ending `.tt` are ERB templates.
- `<variant>/github_audit_rule.rb`: a `Audit::Github::Rules::Base` subclass that registers itself with `Audit::Github::Rules::Registry`. It usually checks that the target repo contains the feature's template files verbatim.

**Opt-in loading:** `require 'way_of_working'` loads only `readme_badge`. Every other built-in feature (including `audit/github`) is enabled with an explicit `require 'way_of_working/<category>/<variant>'`. External plugins are gems named `way_of_working-*`, and `lib/way_of_working.rb` auto-requires their `<name with / for ->/plugin.rb`.

**Zeitwerk:** the gem uses `Zeitwerk::Loader.for_gem`, so file paths must match constant names. A new `github_audit_rule.rb` must be added to the `loader.ignore` list in `lib/way_of_working.rb`, because it depends on the optional audit feature. `zeitwerk_gem_loader_test.rb` and `zeitwerk_test_loader_test.rb` eager-load `lib/` and `test/` to enforce this. That means test files must declare the constant their path implies.

**Config:** `WayOfWorking::Config` stores values the user chooses to keep in `~/.config/way_of_working/config.yaml` (or under `$XDG_CONFIG_HOME`). Keys are namespaced by feature (`code_of_conduct.contact_method`). A generator falls back to the stored value when an option isn't passed and offers to save new values (see `contributor_covenant/generators/init.rb`). `WayOfWorking::Configuration` is something else: organisation gems set the badge name and version there.

## Tests

The tests are Minitest with ActiveSupport and mocha. Generator tests subclass `Rails::Generators::TestCase` and write into `tmp/generators`. They usually check both `run_generator` and `run_generator [], behavior: :revoke`. Audit rule tests stub the Octokit client with mocha.

## Versioning and changelog

SemVer covers the gem's **interface**: CLI commands and options, feature require paths, and the plugin registration API. It doesn't cover generated content ([ADR-0001](docs/decisions/0001-version-the-gem-interface-not-generated-content.md)).
- Refreshing an embedded standard or adding a feature or variant is **MINOR**. A generation bug fix is **PATCH**. Breaking the interface is **MAJOR**.
- If a standard upgrade is drastic enough to surprise existing users, add a **new variant** next to the existing one instead of changing it.
- `CHANGELOG.md` follows Keep a Changelog. Add entries under `[Unreleased]` with a bold feature prefix, e.g. `- **Code of Conduct:** …`.
- Release by bumping `lib/way_of_working/version.rb`, moving the `[Unreleased]` entries under the new version, then running `bundle exec rake release`.

The repo uses its own generators: `docs/decisions/` and `docs/way_of_working/` are generated output, and the source templates live under `lib/**/templates/`.

## Pull requests

Write PR descriptions using the sections in `.github/pull_request_template.md` (What, Why, How, Testing, optional Screenshots, Anything Else).
