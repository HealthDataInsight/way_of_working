---
layout: page
status: REQUIRED
enforcement: manual
---

# Versioning

## Purpose

Define the versioning standard for communicating software changes and managing releases across projects.

## Scope

Applies to all software projects requiring version identification.

## Requirements

Use [Semantic Versioning](https://semver.org) (semver) with format `MAJOR.MINOR.PATCH`:

1. **MAJOR**: Increment for incompatible API changes
2. **MINOR**: Increment for backwards-compatible functionality additions
3. **PATCH**: Increment for backwards-compatible bug fixes

Pre-release and build metadata labels available as extensions.

## Setup

No specific tooling required. Apply version numbers to:

- Git tags
- Package manifests (`package.json`, `Cargo.toml`, etc.)
- Release notes
- Documentation

## Usage

**When to increment:**

- Breaking changes → increment MAJOR (e.g., 1.2.3 → 2.0.0)
- New features (backwards-compatible) → increment MINOR (e.g., 1.2.3 → 1.3.0)
- Bug fixes (backwards-compatible) → increment PATCH (e.g., 1.2.3 → 1.2.4)

**Pre-release versions:** Append hyphen and identifiers (e.g., 1.0.0-alpha, 1.0.0-beta.1)

**Build metadata:** Append plus sign and identifiers (e.g., 1.0.0+20240115)

## Enforcement

Manual enforcement through:

- Code review verification
- Release checklist validation
- Automated CI checks (where configured)

## Examples

```text
0.1.0     → Initial development
1.0.0     → First stable release
1.1.0     → Added new feature
1.1.1     → Fixed bug
2.0.0     → Breaking API change
2.0.0-rc.1 → Release candidate
1.2.3+build.456 → With build metadata
```

## Resources

- [Semantic Versioning Specification](https://semver.org)
- [Semver Calculator](https://semver.npmjs.com) - Determine version impact
