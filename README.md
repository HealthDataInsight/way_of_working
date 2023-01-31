# HDI Engineering Way of Working
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)
[![MegaLinter](https://github.com/HealthDataInsight/way_of_working/workflows/MegaLinter/badge.svg?branch=main)](https://github.com/HealthDataInsight/way_of_working/actions?query=workflow%3AMegaLinter+branch%3Amain)
[![Keep a Changelog v1.1.0 badge][changelog-badge]][changelog]

## Introduction

This framework will describe a consistent, high-quality approach to Software Engineering at HDI.

It is an opinionated approach intending to support rapid development, across numerous projects, by a fungible workforce who can swap between assignments with the minimum friction.

It builds on the [twelve-factor app](https://12factor.net) methodology and is intended to be compatible with the [NHS Digital Software Engineering Quality Framework](https://github.com/NHSDigital/software-engineering-quality-framework) and other frameworks like [the GDS Way](https://gds-way.cloudapps.digital).

The most significant difference here is that we will be opinionated and make technological and process choices. Of course, users are encouraged to discuss and submit Pull Requests (PRs) if they want changes to the choices made, but by making those choices, we can automate many tedious background tasks that are currently manual.

## Installation

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_PRIOR_TO_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

    bundle add UPDATE_WITH_YOUR_GEM_NAME_PRIOR_TO_RELEASE_TO_RUBYGEMS_ORG

If bundler is not being used to manage dependencies, install the gem by executing:

    gem install UPDATE_WITH_YOUR_GEM_NAME_PRIOR_TO_RELEASE_TO_RUBYGEMS_ORG

## Usage

### Changelog

To add a [keep a changelog v1.1.0](https://keepachangelog.com/en/1.1.0/) changelog to your project, use the following at the command line:

    way_of_working init changelog

### Code Of Conduct

To add a [Contributor Covenant](https://www.contributor-covenant.org/version/2/1/code_of_conduct/) Code of Conduct v2.1 to your project, use the following at the command line:

    way_of_working init code_of_conduct --contact-method [CONTACT METHOD]

You will need to enter a contact method, usually an email address. Please thoroughly read the [enforcement guidelines](https://www.contributor-covenant.org/version/2/1/code_of_conduct/#enforcement-guidelines) section of the code and discuss the implications of adopting the code of conduct.

### Decision Records

To add the [Markdown Any Decision Records (MADR)](https://adr.github.io/madr/) v3.0.0 framework to your project, run the following at the command line:

    way_of_working init decision_record

To create a new decision record, run:

    way_of_working new decision_record [NAME]

Where `[NAME]` is the title of your decision record, for example:

    way_of_working new decision_record "Use Markdown Any Decision Records"

### Linter

To add [MegaLinter](https://megalinter.io/) to your project, run the following at the command line:

    way_of_working init linter

to run MegaLinter in your project, run:

    way_of_working exec linter

### Initialise All Components

To add all the Way of Working components to your project, run:

    way_of_working init all --contact-method [CONTACT METHOD]

Providing the Code of Conduct `[CONTACT METHOD]` described above.

### Help

More help on using the command line tool is found by using:

    way_of_working help

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. This RubyGem was created using `bundle gem --exe way_of_working`.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/HealthDataInsight/way_of_working>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/HealthDataInsight/way_of_working/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the WayOfWorking project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/HealthDataInsight/way_of_working/blob/main/CODE_OF_CONDUCT.md).

[changelog]: ./CHANGELOG.md
[changelog-badge]: https://img.shields.io/badge/changelog-Keep%20a%20Changelog%20v1.1.0-%23E05735
