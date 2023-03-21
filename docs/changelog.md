---
layout: page
---

# Changelog

We use [keep a changelog](https://keepachangelog.com/en/1.1.0/) version 1.1.0. It has a well-defined structure that makes it an accessible format for people and tooling.

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
Unlike automatic tools like github-changelog-generator, keep a changelog is a human-written, plain English summary of changes. It is **not** a commit log dump; please do not use it as such.

We recommend that you and your team update the changelog within your Pull Requests, which avoids the need to add to the changelog much later, at release. Please read the [keep a changelog](https://keepachangelog.com/en/1.1.0/) website. It's a single page with lots of important advice about the benefits and dangers of an incomplete changelog, but as it says in the FAQs, you can always revisit and improve a changelog over time.

The Way of Working command line tool scaffolds a new changelog on new and longstanding projects.

On longstanding git-based projects, it reads the release tags and scaffolds a changelog with the expected changes of a [semantically versioned](https://semver.org) project. So, for example, a patch or minor version change won't contain a scaffolded `Removed` section.

Please use the links within the scaffolded changelog to view all the commits between releases to document historical changes.

{: .note }
There is no tooling to support the continued scaffolding of new releases to an existing changelog because the expectation is that you are updating it day-to-day.

{: .highlight }
We want to provide tooling (including a Rails helper method) that reads the changelog and converts it to HTML for inclusion within the project website. Developers could also give it a last-logged-in date to highlight all the changes since a user last logged in. If you would like to contribute to this functionality, let us know.

## Usage

### Adding a changelog to your project

To add a [keep a changelog v1.1.0](https://keepachangelog.com/en/1.1.0/) changelog to your project, use the following at the command line:

    way_of_working init changelog
