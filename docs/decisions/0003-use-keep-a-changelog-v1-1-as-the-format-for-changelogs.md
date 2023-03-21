---
# Configuration for the Jekyll template "Just the Docs"
nav_order: 3
parent: Decision Records

# These are optional elements. Feel free to remove any of them.
status: accepted
date: 2023-01-31
---
# Use keep a changelog v1.1 as the format for changelogs

## Context and Problem Statement

There is enormous variation in the way changelogs are written. We want to adopt a standardised approach that enables them to be read by other contributors and be machine readable for conversion to HTML for end-users. We want one that isn't a dump of version control commit logs.

Which should we choose?

## Considered Options

* [keep a changelog v1.1.0](https://keepachangelog.com/en/1.1.0/)
* [github-changelog-generator](https://github.com/github-changelog-generator/github-changelog-generator#github-changelog-generator-)
* [GNU changelog style guide](https://www.gnu.org/prep/standards/html_node/Style-of-Change-Logs.html#Style-of-Change-Logs)
* Roll-our-own solution.
* Have no conventions for common approach to changelogs.

## Decision Outcome

Chosen option: "keep a changelog", because

* It is an accessible format, both for people and tooling.
* It is a human-written, plain English summary of changes, not a commit log dump.
* It has a well defined structure that makes automation easier.
* GNU changelog style is inadequate.

### Consequences

* Good, because we can programatically create a template changelog for the first time on new and existing projects
* Good, because scaffolds the changes needed when we tag a new release
* Good, because we can provide helpers (using existing tooling) than convert the changelog into HTML for inclusion in an end user system
* Bad, because, unlike fully automated tools like github-changelog-generator, effort is required to turn commit messages into plain English.
