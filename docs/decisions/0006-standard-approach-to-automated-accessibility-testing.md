---
# Configuration for the Jekyll template "Just the Docs"
nav_order: 6
parent: Decision Records

# These are optional elements. Feel free to remove any of them.
status: accepted
date: 2023-03-03
---
# Standard approach to automated accessibility testing

## Context and Problem Statement

The services we design need to be accessible and meet WCAG 2.1 level AA as a minimum, preferably meeting WCAG 2.1 level AAA where possible.
Alongside human auditing, we want a consistent approach to automated accessibility testing, so which tool should we choose?

We should provide tooling around the edges that:

- creates a GitHub Action to test as part of the CI/CD process,
- providers Rake/Thor task(s) to run the tests locally.

<!-- This is an optional element. Feel free to remove. -->
## Decision Drivers

* It's a legal requirement to ensure that the websites and mobile applications we produce are accessible. This is done by showing compliance to the 'AA' standard of the WCAG 2.1 guidelines.

## Considered Options

* [Pa11y](https://pa11y.org)
* [aXe](https://www.deque.com/axe/)
* [Google Lighthouse](https://developer.chrome.com/docs/lighthouse/overview/)
* [HTML_CodeSniffer](https://squizlabs.github.io/HTML_CodeSniffer/)
* [SortSite](https://www.powermapper.com/products/sortsite/)
* [WAVE](https://wave.webaim.org)
* [ANDI](https://www.ssa.gov/accessibility/andi/help/howtouse.html)

## Decision Outcome

Chosen option: "Pa11y" because:
* it is a tool that we have already used as part of a GitHub workflow,
* we can run it twice to measure AA and AAA compliance,
* it runs [HTML_CodeSniffer](https://squizlabs.github.io/HTML_CodeSniffer/), [aXe](https://www.deque.com/axe/) or both as "test runners"

## More Information

GOV.UK Service Manual:
- [Making your service accessible: an introduction](https://www.gov.uk/service-manual/helping-people-to-use-your-service/making-your-service-accessible-an-introduction)
- [Understanding WCAG 2.1](https://www.gov.uk/service-manual/helping-people-to-use-your-service/understanding-wcag)
- [Getting an accessibility audit](https://www.gov.uk/service-manual/helping-people-to-use-your-service/getting-an-accessibility-audit)
- [Testing for accessibility](https://www.gov.uk/service-manual/helping-people-to-use-your-service/testing-for-accessibility#automated-testing)

Potential Auditors:
- [Digital Accessibility Centre](https://digitalaccessibilitycentre.org/auditandaccreditation.html)
- [Accessibility Services](https://www.accessibility-services.co.uk/services/digital-accessibility/digital-accessibility-assessment/)
