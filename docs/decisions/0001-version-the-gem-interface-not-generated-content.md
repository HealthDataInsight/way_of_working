---
# Configuration for the Jekyll template "Just the Docs"
nav_order: 1
parent: Decision Records
---
# Version the Gem Interface, Not the Generated Content

## Context and Problem Statement

Features that were previously extracted into separate plugin gems are being bundled back into this
gem as opt-in built-in features (Changelog, Code of Conduct, Decision Records, Inclusive Language,
Pull Request Template). Each feature embeds an external standard at a particular version — for
example the Code of Conduct feature ships Contributor Covenant v2.1, and Decision Records ships
MADR v3.

This project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html). If every breaking
change to a bundled standard (e.g. upgrading Contributor Covenant 2.1 → 3, which is effectively a
rewrite) were treated as a breaking change to the gem, the major version would inflate rapidly
towards numbers like v14. How should we version the gem as the standards its features embed evolve?

## Decision Drivers

* Rapid major-version inflation forces downstream consumers who pin `~> N.0` to hand-edit their
  constraints for changes that do not actually break the gem's interface.
* Existing users should not have their generated artefacts change underneath them without opting in.
* The gem recommends Semantic Versioning to its own users (via the `versioning-semver` feature), so
  it should model correct SemVer rather than abandon it.
* Per-feature history should remain easy to follow even though all features share one version.

## Considered Options

* **Scope SemVer to the gem's interface** — the version reflects the CLI, require paths and plugin
  API; the content a generator emits is not part of the versioned contract.
* **Calendar Versioning (CalVer)** — date-based versions (e.g. `2026.06.0`); drop breaking-change
  signalling entirely.
* **Per-feature version numbers** — give each feature its own independently incremented version.

## Decision Outcome

Chosen option: **"Scope SemVer to the gem's interface"**, combined with **additive variants** for
drastic standard upgrades, because it keeps the major version meaningful and slow-moving while
still giving users a clear, opt-in path through breaking standard changes.

The versioned public contract is:

* the **CLI surface** — commands and their required options
  (e.g. `way_of_working init code_of_conduct --contact-method`),
* the **require paths** of built-in features
  (e.g. `require 'way_of_working/code_of_conduct/contributor_covenant'`),
* the **plugin registration API** (`SubCommands::*.register`, and the `way_of_working-*` autoload in
  `lib/way_of_working.rb`).

It follows that:

* Refreshing the standard a feature embeds is **new behaviour → MINOR**.
* A bug fix in generation is **PATCH**.
* **MAJOR** is reserved for breaking the contract above — renaming or removing a command or option,
  moving a require path, or changing the plugin API.

For a standard update drastic enough to surprise existing users, prefer adding a **new variant**
rather than mutating the existing one. Features are already namespaced as `category/variant`
(`code_of_conduct/contributor_covenant`, `decision_record/madr`), so a v3 of Contributor Covenant
can ship as a new variant alongside the existing one; both coexist and consumers opt in by require
path. This keeps the change additive (MINOR) and leaves existing users untouched.

### Consequences

* Good, because the major version stays meaningful and rare, so `~> N.0` pins keep working across
  routine standard refreshes.
* Good, because breaking standard upgrades become opt-in rather than imposed on re-running a
  generator.
* Good, because it requires no architectural change — the variant namespace already exists.
* Neutral, because all features still share a single version number; per-feature history is carried
  by a changelog convention (see Validation) rather than separate version streams.
* Bad, because contributors must consciously classify each change against the interface contract
  rather than reflexively bumping major for anything that "looks breaking".

## Validation

* The version-bump checklist in `CONTRIBUTING.md` encodes this policy and is applied at release time.
* Feature-affecting changelog entries are scoped with a bold feature prefix
  (e.g. `- **Code of Conduct:** …`) so each feature's history is greppable within the single
  `CHANGELOG.md`.

## More Information

* Rejected **CalVer** because it discards the breaking-change signal that `~>` pinning relies on and
  would undercut the SemVer the gem advocates to its users.
* Rejected **per-feature version numbers** because re-decoupling versions runs counter to the
  consolidation of features back into the single gem.
* The concrete Contributor Covenant 2.1 → 3 upgrade is tracked separately; this decision only
  establishes how it should be versioned when it lands.
