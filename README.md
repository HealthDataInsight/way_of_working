# HDI Engineering Way of Working

## Introduction

This framework will describe a consistent, high-quality approach to Software Engineering at HDI.

It is an opinionated approach intending to support rapid development, across numerous projects, by a fungible workforce who can swap between assignments with the minimum friction.

It builds on the [twelve-factor app](https://12factor.net) methodology and is intended to be compatible with the [NHS Digital Software Engineering Quality Framework](https://github.com/NHSDigital/software-engineering-quality-framework) and other frameworks like [the GDS Way](https://gds-way.cloudapps.digital).

The most significant difference here is that we will be opinionated and make technological and process choices. Of course, users are encouraged to discuss and submit Pull Requests (PRs) if they want changes to the choices made, but by making those choices, we can automate many tedious background tasks that are currently manual.

## WayOfWorking Rails Plugin

As initial support is for Rails projects, support for use of the framework is implemented as a Rails plugin to use Rails generators. Future iterations could potentially use Thor and/or Rails Generators directly (to support non-Rails projects).

### Usage

This plugin was created using `rails plugin new --skip-action-cable --skip-action-mailer --skip-active-record --skip-active-job way_of_working`.

### Installation
Add this line to your application's Gemfile:

```ruby
gem "way_of_working"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install way_of_working
```

### Contributing

1. Fork it ( <https://github.com/HealthDataInsight/way_of_working/fork> )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Please note that this project is released with a Contributor Code of Conduct. By participating in this project you agree to abide by its terms.

### License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
