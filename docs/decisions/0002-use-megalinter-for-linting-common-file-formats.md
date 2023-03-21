---
# Configuration for the Jekyll template "Just the Docs"
nav_order: 2
parent: Decision Records

status: accepted
date: 2023-01-05
---
# Use MegaLinter for linting common file formats

## Context and Problem Statement

We want to consistently manage the running of a large number of linters against our codebase containing a wide range of file formats, providing projects with a preconfigured GitHub Action.

We also want to store our standard linter configurations centrally, so that contributors can comment on, and propose changes to, our coding standards. With coding standards we can move more quickly between projects. There are several tools which orchestrate this task. Which one should we adopt?

## Considered Options

* [Super-Linter](https://github.com/github/super-linter) for all languages, formats and tools.
* [MegaLinter](https://megalinter.io/) is an Open-Source tool for CI/CD workflows that analyzes the consistency of your code, IAC, configuration, and scripts in your repository sources, to ensure all your projects sources are clean and formatted whatever IDE/toolbox is used by their developers, powered by OX Security.
* Roll-our-own solution.
* Have no conventions for common approach to linting.

## Decision Outcome

Chosen option: "MegaLinter", because:

* The differences between MegaLinter and Super-Linter are [well documented](https://megalinter.io/latest/mega-linter-vs-super-linter), but having used both on this project first had, MegaLinter was more than 8 time faster in linting the project on my local machine than Super-Linter.
* The ability to enable/disable linters allows us to take a more bespoke approach where the standard linter isn't adequate. E.g. The Ruby linter, Rubocop, contained in the Docker container, doesn't have access to the Rails linting we would adopt to adhere to the existing NDRS standard.

Initially we will lint bash, c++, c#, coffeescript, dart, go, java, javascript, jsx, kotlin, make, python, R, rust, scala, SQL, swift, typescript, tsx, css, sass, html, json, markdown, xml, yaml, github actions, ansible, ARM, cloudformation, kubernetes, openapi, puppet and terraform files.

These have been chosen as an initial list where they have been, are or could be used in projects both internally and with partner organisations.

### Consequences

* Good, because we can spend less time writing a bespoke orchestration tool that would have to manage all the different output formats from all the different linters.
* Good, because we get secret scanning, security scanning of Infrastructure-as-Code code and dependency scanning as well as style checking.
* Neutral, because where a particular coding style has been adopted for a particular language, it can be adopted here.
* Neutral, because the rake task to run MegaLinter abstracts away any complexity with using Docker. Contributors only need to have Docker installed.
* Bad, because developers will need to adapt to the standard coding style, if it is unfamiliar to them.
