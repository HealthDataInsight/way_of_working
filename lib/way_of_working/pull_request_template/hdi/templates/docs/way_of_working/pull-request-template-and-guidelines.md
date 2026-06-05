---
layout: page
status: REQUIRED
enforcement: manual
---

# Pull Request Template and Guidelines

## Purpose

Standardise PR submissions to ensure consistent context, improve review efficiency, and maintain searchable project history.

## Scope

Applies to all pull requests across team projects.

## Requirements

- PR template must be present in repository
- All PRs must include:
  - Summary of changes
  - Rationale (why)
  - Associated issue/ticket numbers
- Follow [Code of Conduct](code-of-conduct.md) and GitHub's [How to write the perfect pull request][perfect-pr] guidelines

{: .important }
A Pull Request doesn't begin and end with the template. The tone of the request and any subsequent feedback is also very important. Read GitHub's PR communication guidelines in [How to write the perfect pull request][perfect-pr].

## Setup

Initialise PR template:

```bash
way_of_working init pull_request_template
```

## Usage

Use the template when creating PRs. Provide all requested information professionally.

## Enforcement

Manual review during PR submission and code review process.

## Resources

- [How to write the perfect pull request][perfect-pr]
- [Code of Conduct](code-of-conduct.md)

[perfect-pr]: https://github.blog/2015-01-21-how-to-write-the-perfect-pull-request/
