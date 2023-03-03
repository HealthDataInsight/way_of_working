---
# Configuration for the Jekyll template "Just the Docs"
nav_order: 5
parent: Decision Records

# These are optional elements. Feel free to remove any of them.
status: accepted
date: 2023-03-03
---
# Standardised approach to versioning

## Context and Problem Statement

"Dependency hell" is the complex and frustrating situation where a software project has multiple dependencies, but installing or updating one dependency leads to conflicts or incompatibilities with others, causing errors and delays in the development process.

What version numbering scheme should we adopt to avoid dependency hell?

## Considered Options

* [Semantic Versioning](https://semver.org)
* [Calendar Versioning](https://calver.org)

## Decision Outcome

Chosen option: "Semantic Versioning" because:
* it is a well established and widely used version numbering scheme
* allows us to quickly identify breaking changes to dependencies
