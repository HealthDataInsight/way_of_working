# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Removed

- Removed completely unused test resource file

### Fixed

- Corrected the badge rule brittle loading and signature

## [2.0.0] - 2024-10-24

### Added

- Added a panel for README badges and a Way of Working badge
- Added a plugin system for new functionality

### Removed

- Moved MADR Decision Records to a separate plugin
- Moved Contributor Covenant Code of Conduct to a separate plugin
- Moved MegaLinter to a separate plugin
- Moved Keep a Changelog to a separate plugin
- Removed GitHub Pages

### Security

- Addressed known dependabot vulnerabilities

### Fixed

- A Changelog can now be created in project that hasn't been initialised as a git repository
- Fixed the way active_support is used in this (non-rails) project

## [1.0.0] - 2023-02-17

### Added

- Added Markdown Any Decision Records (MADR) with generator commands
- Added Contributor Covenant Code of Conduct with generator command
- Added MegaLinter for linting common file formats with generator command and rake task
- Added Keep a Changelog with generator command
- Added GitHub Pages documentation site

### Change

- Switched from a Rails Engine to (nearly) vanilla Thor, to support non-rails projects
- Switched to a cached copy of the Code of Conduct

### Fixed

- Corrected use of relative paths in the rubocop config file

[unreleased]: https://github.com/HealthDataInsight/way_of_working/compare/v2.0.0...HEAD
[2.0.0]: https://github.com/HealthDataInsight/way_of_working/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/HealthDataInsight/way_of_working/releases/tag/v1.0.0
