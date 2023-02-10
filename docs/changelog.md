---
layout: page
nav_order: 2
---

# Changelog

We use [keep a changelog](https://keepachangelog.com/en/1.1.0/) version 1.1.0. It has a well defined structure that makes it an easy to *read* format, both for people and tooling.

To quote from their website:

> Guiding Principles:
> * Changelogs are for humans, not machines.
> * There should be an entry for every single version.
> * The same types of changes should be grouped.
> * Versions and sections should be linkable.
> * The latest version comes first.
> * The release date of each version is displayed.
> * Mention whether you follow Semantic Versioning.

Grouping changes into a clear set of change types:

> * `Added` for new features.
> * `Changed` for changes in existing functionality.
> * `Deprecated` for soon-to-be removed features.
> * `Removed` for now removed features.
> * `Fixed` for any bug fixes.
> * `Security` in case of vulnerabilities.

{: .important }
Unlike automatic tools like github-changelog-generator, keep a changelog is a human-written, plain English summary of changes. It is **not** a commit log dump and please do not use it as such.

We recommend that you and your team get into the habit of updating the changelog within your Pull Requests, which avoids the need to add to the changelog much later, at release.

The Way of Working command line tool scaffolds a new changelog on both new and longstanding projects.

On longstanding git-based projects, it reads the release tags and scaffolds a changlog with the expected changes of a [semantically versioned](https://semver.org) project. For example, a patch or minor version change won't contain a scaffolded `Removed` section. Please use the links within the scaffolded changelog to view all the commits between releases to document historical changes.

{: .note }
There is no tooling to support the continued scaffolding of new releases to an existing changelog, because the expectation is that you are updating it day-to-day.

{: .highlight }
We want to provide tooling (including a Rails helper method) that reads the changlog and converts it to HTML for inclusion within the project website. Ideally it could also be given a last logged in date, to highlight all the changes since a user last logged in. If you want to contribute this functionality, fork the repository and create a Pull Request.

## Usage

### Adding a changelog to your project

To add a [keep a changelog v1.1.0](https://keepachangelog.com/en/1.1.0/) changelog to your project, use the following at the command line:

    way_of_working init changelog
