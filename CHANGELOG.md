# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Added Markdown Any Decision Records (MADR) with generator commands
- Added Contributor Covenant Code of Conduct with generator command
- Added MegaLinter for linting common file formats with generator command and rake task
- Added Keep a Changelog with generator command

### Change

- Switched from a Rails Engine to (nearly) vanilla Thor, to support non-rails projects
- Switched to a cached copy of the Code of Conduct

### Fixed

- Corrected use of relative paths in the rubocop config file
