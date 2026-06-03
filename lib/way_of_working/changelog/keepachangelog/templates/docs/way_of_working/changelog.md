---
layout: page
status: REQUIRED
enforcement: manual
---

# Changelog

![Keep a Changelog v1.1.0 badge][changelog-badge]

## Purpose

Maintain a human-readable project history that documents all notable changes between versions in plain English.

## Scope

All projects must maintain a changelog using [Keep a Changelog v1.1.0][keep-a-changelog] format.

## Requirements

- Human-written plain English summaries (not commit log dumps)
- Entry for every version
- Latest version listed first
- Release date displayed for each version
- Changes grouped by type: `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, `Security`
- Versions and sections must be linkable
- Follow [Semantic Versioning][semver]
- Update changelog within Pull Requests, not at release time

## Setup

Initialise a changelog for your project:

```bash
way_of_working init changelog
```

For git-based projects with existing releases, this scaffolds sections based on semantic version tags.

## Usage

1. Update the `Unreleased` section in each Pull Request
2. Group changes under appropriate headings
3. Write clear, user-focused descriptions
4. Move `Unreleased` changes to a version section at release
5. Use scaffolded commit links to document historical changes

## Enforcement

- Changelog updates required in Pull Request reviews
- No automatic commit log dumps permitted

## Examples

```markdown
## [1.2.0] - 2025-10-22

### Added
- User authentication via OAuth2
- Export data to CSV functionality

### Fixed
- Memory leak in background job processor
```

## Resources

- [Keep a Changelog][keep-a-changelog]
- [Semantic Versioning][semver]

[changelog-badge]: https://img.shields.io/badge/changelog-Keep%20a%20Changelog%20v1.1.0-%23E05735
[keep-a-changelog]: https://keepachangelog.com/en/1.1.0/
[semver]: https://semver.org
