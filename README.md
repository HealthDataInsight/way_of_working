# Way of Working

<!-- Way of Working: Main Badge Holder Start -->
![Way of Working Badge](https://img.shields.io/badge/Way_of_Working-v2.0.1-%238169e3?labelColor=black)
<!-- Way of Working: Additional Badge Holder Start -->
<!-- Way of Working: Badge Holder End -->

[![Gem Version](https://badge.fury.io/rb/way_of_working.svg)](https://badge.fury.io/rb/way_of_working)
<br />
[![MegaLinter](https://github.com/HealthDataInsight/way_of_working/workflows/MegaLinter/badge.svg?branch=main)](https://github.com/HealthDataInsight/way_of_working/actions?query=workflow%3AMegaLinter+branch%3Amain)
[![Inclusive Language](https://github.com/HealthDataInsight/way_of_working/actions/workflows/inclusive-language.yml/badge.svg)](https://github.com/HealthDataInsight/way_of_working/actions/workflows/inclusive-language.yml)

## Introduction

This tool underpins the Way of Working framework, used to describe a consistent, high-quality approach to Software Engineering. It is intended as an opinionated approach supporting rapid development, across numerous projects, by a fungible workforce who can swap between assignments with the minimum friction.

It consists command line tool that uses a modular, plugin-based system to gain functionality, allowing for organisations to pick and choose different solutions for the same feature.
Organisations can create their own gem which defines the specific plugin dependencies which form their way of working. See the [Way of Working for HDI](https://github.com/HealthDataInsight/way_of_working-for-hdi) as an example.

There are subcommands that plugins hook into which enable them to add GitHub actions, configuration and other files to a project and GitHub pages outlining the tooling choice and thinking behind it.

Below is a list of plugins that have been implemented so far:

| Feature               | Plugin                                 | Description                                                                            |
| --------------------- | -------------------------------------- | ---------------------------------------------------------------------------------------|
| Audit                 | [audit-github]                         | A framework for rules to check for incorrect content and configuration of GitHub repos |
| Changelog             | Built-in (changelog/keepachangelog)    | Implements [keepachangelog v1.1] — bundled, opt in by `require` (see [Built-in Features](#built-in-features)) |
| Code Linting          | [code_linting-hdi]                     | Implements a combination of [MegaLinter] and [RuboCop] built on NDRS standards         |
| Code of Conduct       | [code_of_conduct-contributor_covenant] | Implements [Contributor Covenant v2.1]                                                 |
| Decision Records      | Built-in (decision_record/madr)        | Implements [MADR v3] — bundled, opt in by `require` (see [Built-in Features](#built-in-features)) |
| Inclusive Language    | Built-in (inclusive_language/alex)     | Implements [alex] — bundled, opt in by `require` (see [Built-in Features](#built-in-features)) |
| Pull Request Template | [pull_request_template-hdi]            | Implements a bespoke PR template                                                       |
| Versioning            | [versioning-semver]                    | Implements [Semantic Versioning v2.0.0]                                                |

Some features are **Built-in** — they ship inside this gem and are enabled by requiring them (see [Built-in Features](#built-in-features)); the others are separate plugin gems that you add as dependencies.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add way_of_working
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install way_of_working
```

## Usage

### Initialise All Components

To add all the Way of Working components to your project, run:

```bash
way_of_working init all --contact-method [CONTACT METHOD]
```

You will need to provide the Code of Conduct `[CONTACT METHOD]`, usually an email address, for community leaders to receive reports of unacceptable behavior.

### Built-in Features

Some features are bundled with this gem rather than shipped as separate plugins. These built-in features are **opt in**: enable one by requiring it wherever you load Way of Working — for example in your organisation's Way of Working gem, or in your project's `Rakefile`.

#### Changelog

Keeping a curated, human-readable changelog makes it easy for users and contributors to see what has changed between releases without trawling through the commit history.

This feature uses [Keep a Changelog v1.1][keepachangelog v1.1] to generate a `CHANGELOG.md`, seeding it with sections derived from your git tags and commit messages where possible. Enable it by requiring it:

```ruby
require 'way_of_working/changelog/keepachangelog'
```

Once required, a subcommand becomes available:

```bash
# Add a Keep a Changelog CHANGELOG.md and documentation to your project
way_of_working init changelog
```

#### Decision Records

Recording the context and reasoning behind significant decisions helps current and future contributors understand why a project is the way it is, avoids relitigating settled questions, and onboards newcomers faster.

This feature uses [Markdown Any Decision Records (MADR)][MADR v3] to capture decisions as version-controlled Markdown alongside your code. Enable it by requiring it:

```ruby
require 'way_of_working/decision_record/madr'
```

Once required, two subcommands become available:

```bash
# Add the decision records index, template and first record to your project
way_of_working init decision_record

# Create a new decision record
way_of_working new decision_record "Title of the decision"
```

#### Inclusive Language

Using insensitive and inconsiderate language can cause harm to others, create barriers to communication, and damage relationships. It can make people feel excluded, disrespected, and devalued, and may perpetuate negative stereotypes and biases.

This feature uses [alex] for automated testing of inclusive language, both at the command line and as a GitHub workflow. Enable it by requiring it:

```ruby
require 'way_of_working/inclusive_language/alex'
```

Once required, two subcommands become available:

```bash
# Add the alex config, .alexignore, GitHub Action and documentation to your project
way_of_working init inclusive_language

# Run the inclusive language checks
way_of_working exec inclusive_language
```

### Help

More help on using the command line tool is found by using:

```bash
way_of_working help
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.
This RubyGem was created using `bundle gem --exe way_of_working`.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

When creating plugins, the convention is to create them within the WayOfWorking and feature namespaces. E.g. 

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/HealthDataInsight/way_of_working>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/HealthDataInsight/way_of_working/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the WayOfWorking project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/HealthDataInsight/way_of_working/blob/main/CODE_OF_CONDUCT.md).

[alex]:https://alexjs.com
[Contributor Covenant v2.1]: https://www.contributor-covenant.org
[keepachangelog v1.1]: https://keepachangelog.com/en/1.1.0/
[MADR v3]: https://adr.github.io/madr/
[MegaLinter]: https://megalinter.io/
[RuboCop]: https://rubocop.org
[Semantic Versioning v2.0.0]: https://semver.org/spec/v2.0.0.html
[audit-github]: https://github.com/HealthDataInsight/way_of_working-audit-github
[code_linting-hdi]: https://github.com/HealthDataInsight/way_of_working-code_linting-hdi
[code_of_conduct-contributor_covenant]: https://github.com/HealthDataInsight/way_of_working-code_of_conduct-contributor_covenant
[pull_request_template-hdi]: https://github.com/HealthDataInsight/way_of_working-pull_request_template-hdi
[versioning-semver]: https://github.com/HealthDataInsight/way_of_working-versioning-semver
