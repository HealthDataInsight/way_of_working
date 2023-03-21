---
# Configuration for the Jekyll template "Just the Docs"
nav_order: 4
parent: Decision Records

# These are optional elements. Feel free to remove any of them.
status: accepted
date: 2023-03-03
---
# End-to-End (aka System) Testing

## Context and Problem Statement

Many solutions are specific to the technology they are testing. We want to adopt an approach that enables contributors to read and write tests across projects without the brittleness of some solutions.

Which should we choose?

We should provide tooling around the edges that initially scaffolds the tool into a Rails application and creates a GitHub Action. Support for other tech stacks would follow.

## Considered Options

* [Cypress](https://www.cypress.io) JavaScript web testing and component testing framework.
* [Capybara](http://teamcapybara.github.io/capybara/) using the [Selenium](https://www.selenium.dev) driver and Chrome browser (the Rails default).
* [Capybara](http://teamcapybara.github.io/capybara/) using the [Cuprite](https://cuprite.rubycdp.com) driver and Chrome browser.

## Decision Outcome

Chosen option: "Cypress" because:
* Although tests need to be written in JavaScript or TypeScript, the tested web application can be in any language. It also has a new experimental feature, where non-developers can click and record tests by interacting with the tested app.
* Debugging (both the tested application and the tests themselves) is effortless, with "time travel" showing you what the app looked like at each test step.
* It can be integrated into a Rails application using [cypress-rails](https://github.com/testdouble/cypress-rails). [CypressOnRails](https://github.com/shakacode/cypress-on-rails) was also considered.

### Consequences

* Good, because end-to-end testing increases the quality of our applications and reduces the chances of downtime or data loss.
* Good, because we can spend more time creating end-to-end tests than fighting the test framework.
* Neutral, because developers will need to introduce `data-test` HTML attributes into our applications to enable them to be reliably tested.

## More Information

In order to not delay the decision to adopt Cypress, the Rails initialisation tooling will be added later.
