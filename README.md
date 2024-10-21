# Way of Working

<!-- Way of Working: Main Badge Holder Start -->
![Way of Working Badge](https://img.shields.io/badge/Way_of_Working-v2.0.0-%238169e3?labelColor=black)
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

There are subcommands that plugins hook into whcih enable them to add GitHub actions, configuration and other files to a project and GitHub pages outlining the tooling choice and thinking behind it.

Below is a list of plugins that have been implemented so far:

| Feature               | Plugin                                 | Description                                                                    |
| --------------------- | -------------------------------------- | ------------------------------------------------------------------------------ |
| Changelog             | [changelog-keepachangelog]             | Implements [keepachangelog v1.1]                                               |
| Code Linting          | [code_linting-hdi]                     | Implements a combination of [MegaLinter] and [RuboCop] built on NDRS standards |
| Code of Conduct       | [code_of_conduct-contributor_covenant] | Implements [Contributor Covenant v2.1]                                         |
| Decision Records      | [decision_record-madr]                 | Implements [MADR v3]                                                           |
| Inclusive Language    | [inclusive_language-alex]              | Implements [alex]                                                              |
| Pull Request Template | [pull_request_template-hdi]            | Implements a bespoke PR template                                               |

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
[changelog-keepachangelog]: https://github.com/HealthDataInsight/way_of_working-changelog-keepachangelog
[code_linting-hdi]: https://github.com/HealthDataInsight/way_of_working-code_linting-hdi
[code_of_conduct-contributor_covenant]: https://github.com/HealthDataInsight/way_of_working-code_of_conduct-contributor_covenant
[decision_record-madr]: https://github.com/HealthDataInsight/way_of_working-decision_record-madr
[inclusive_language-alex]: https://github.com/HealthDataInsight/way_of_working-inclusive_language-alex
[pull_request_template-hdi]: https://github.com/HealthDataInsight/way_of_working-pull_request_template-hdi
