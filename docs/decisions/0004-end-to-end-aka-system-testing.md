---
# These are optional elements. Feel free to remove any of them.
status: proposed
date: 2023-01-31
---
# End to End (aka System) Testing

## Context and Problem Statement

Many solutions are specific to the technology they are testing. We want to adopt an approach that enables contributors to easily read and write tests across projects, without the brittleness of some solutions.

Which should we choose?

We should provide tooling around the edges that initially just scaffolds the tool into Rails application and creates a GitHub Action. Support for other tech stacks would follow.

<!-- This is an optional element. Feel free to remove. -->
## Decision Drivers

* {decision driver 1, e.g., a force, facing concern, …}
* {decision driver 2, e.g., a force, facing concern, …}
* … <!-- numbers of drivers can vary -->

## Considered Options

* [Cypress](https://www.cypress.io) JavaScript web testing and component testing framework.
* [Capybara](http://teamcapybara.github.io/capybara/) using the [Selenium](https://www.selenium.dev) driver and Chrome browser (the Rails default).
* [Capybara](http://teamcapybara.github.io/capybara/) using the [Cuprite](https://cuprite.rubycdp.com) driver and Chrome browser.
* {title of option 4}
* … <!-- numbers of options can vary -->

## Decision Outcome

Chosen option: "{title of option 1}", because
{justification. e.g., only option, which meets k.o. criterion decision driver | which resolves force {force} | … | comes out best (see below)}.

<!-- This is an optional element. Feel free to remove. -->
### Consequences

* Good, because {positive consequence, e.g., improvement of one or more desired qualities, …}
* Bad, because {negative consequence, e.g., compromising one or more desired qualities, …}
* … <!-- numbers of consequences can vary -->

<!-- This is an optional element. Feel free to remove. -->
## Validation

{describe how the implementation of/compliance with the ADR is validated. E.g., by a review or an ArchUnit test}

<!-- This is an optional element. Feel free to remove. -->
## Pros and Cons of the Options

### {title of option 1}

<!-- This is an optional element. Feel free to remove. -->
{example | description | pointer to more information | …}

* Good, because {argument a}
* Good, because {argument b}
<!-- use "neutral" if the given argument weights neither for good nor bad -->
* Neutral, because {argument c}
* Bad, because {argument d}
* … <!-- numbers of pros and cons can vary -->

### {title of other option}

{example | description | pointer to more information | …}

* Good, because {argument a}
* Good, because {argument b}
* Neutral, because {argument c}
* Bad, because {argument d}
* …

<!-- This is an optional element. Feel free to remove. -->
## More Information

{You might want to provide additional evidence/confidence for the decision outcome here and/or
 document the team agreement on the decision and/or
 define when this decision when and how the decision should be realized and if/when it should be re-visited and/or
 how the decision is validated.
 Links to other decisions and resources might here appear as well.}
