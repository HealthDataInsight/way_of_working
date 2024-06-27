# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Added Cypress end-to-end testing
- Adopted Semantic Versioning
- Added pa11y automated accessibility testing
- Added dark mode support to our GitHub pages theme
- Added alex inclusive language testing
- Decided on Cabin as our Software-as-a-Service (SaaS) Web Analytics Solution
- Added a Decision Record issue template
- Added a panel for README badges and an HDI Way of Working badge
- Added a Pull Request template and communications guidelines
- Added a document command to update the list of used and available linters
- Added Swiftlint build phase to Xcode projects

### Change

- Bumped GitHub Pages gem dependencies

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

[unreleased]: https://github.com/HealthDataInsight/way_of_working/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/HealthDataInsight/way_of_working/releases/tag/v1.0.0
