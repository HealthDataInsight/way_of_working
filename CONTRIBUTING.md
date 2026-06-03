# Contributing

Bug reports and pull requests are welcome on GitHub at
<https://github.com/HealthDataInsight/way_of_working>. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to the
[code of conduct](CODE_OF_CONDUCT.md).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then run `rake test` to run
the tests. You can also run `bin/console` for an interactive prompt that lets you experiment.

## Versioning

This project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html), but SemVer here
governs the gem's **public interface**, not the content of the artefacts its generators emit. The
versioned contract is:

* the **CLI surface** — commands and their required options;
* the **require paths** of built-in features
  (e.g. `require 'way_of_working/code_of_conduct/contributor_covenant'`);
* the **plugin registration API** (`SubCommands::*.register`, the `way_of_working-*` autoload).

Refreshing the standard a feature embeds (e.g. a new Contributor Covenant or MADR version) changes
generated content but not the interface, so it is **not** a major change. See
[ADR-0001](docs/decisions/0001-version-the-gem-interface-not-generated-content.md) for the full
rationale.

### Choosing the version bump

| Change | Bump |
| --- | --- |
| Rename/remove a command or required option, move a feature's require path, or change the plugin API | **MAJOR** |
| Refresh the standard a feature embeds; add a new feature or variant | **MINOR** |
| Drastic standard upgrade shipped as a **new variant** alongside the existing one | **MINOR** (additive) |
| Bug fix in generation or generated output | **PATCH** |

For a standard update drastic enough to surprise existing users (e.g. Contributor Covenant
2.1 → 3, effectively a rewrite), add a **new variant** under the feature's `category/variant`
namespace rather than mutating the existing one. Both variants then coexist and consumers opt in by
require path — keeping the change additive and leaving existing users untouched.

### Changelog convention

All notable changes are recorded in `CHANGELOG.md` following
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Scope feature-affecting entries with a
bold feature prefix so each feature's history stays greppable within the single file, e.g.:

```text
- **Code of Conduct:** upgraded Contributor Covenant 2.1 → 3 via new `contributor_covenant_v3` variant
```

## Releasing

To install this gem onto your local machine, run `bundle exec rake install`. To release a new
version:

1. Decide the bump using the table above.
2. Update the version number in `lib/way_of_working/version.rb`.
3. Move the `[Unreleased]` changelog entries under the new version heading.
4. Run `bundle exec rake release`, which creates a git tag for the version, pushes the commits and
   tag, and pushes the `.gem` file to [rubygems.org](https://rubygems.org).
