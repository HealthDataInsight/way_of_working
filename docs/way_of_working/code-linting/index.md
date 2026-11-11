---
has_children: true
layout: page
status: REQUIRED
enforcement: manual
---

# Code Linting

## Overview

We use [MegaLinter](https://megalinter.io/) for most of our linting, but we use [RuboCop](https://rubocop.org) separately for Ruby to support Minitest and Rails cops.

Linters help by:
- Catching syntax errors, undefined variables, and unused code early
- Ensuring consistent code style across teams and projects
- Providing automated quality improvements and best practices
- Saving time in code review and debugging

## Setup

Add linting to your project:

```bash
way_of_working init code_linting
```

This copies organisational coding standards and GitHub Actions workflows to your project.

{: .note }
For Xcode projects, a SwiftLint build phase is automatically added to the project config.

## Usage

Run linting locally:

```bash
way_of_working exec code_linting
```

executes both MegaLinter and RuboCop against your code.

## Configuration

Language-specific configs are in the project root or `.github/linters/`. See [linters.md](linters.md) for the complete list.

To customise for your project, talk to a member of [code-standards-team](https://github.com/orgs/HealthDataInsight/teams/code-standards-team) and modify the config files as needed, keeping changes minimal and well documented.
Pull Request changing linting configs require review by a member of code-standards-team.

## Handling Exceptions

On the rare occasions when linters flag false positives, turn off rules with comments giving your justification:

```python
# pylint: disable=line-too-long - URL cannot be broken
LONG_URL = "https://example.com/very/long/path/..."
```

## Documentation

Generate project documentation:

```bash
way_of_working exec document
```

{: .important }
If you disagree with any linter or coding style, please fork the Way of Working code linting [repository](https://github.com/HealthDataInsight/way_of_working-code_linting-hdi) and create a pull request with your proposed changes. The current standards are a starting point intended to evolve with team consensus.

## Resources

- [MegaLinter documentation](https://megalinter.io/)
- [RuboCop documentation](https://rubocop.org)
- [Active linters list](linters.md)
