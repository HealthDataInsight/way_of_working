---
layout: page
---

# End-to-End Testing

We have adopted [Cypress](https://www.cypress.io) for end-to-end web application testing.

End-to-end testing (also known as system testing) is essential to the software development lifecycle, especially for web applications. End-to-end tests help ensure that all the application components work together as intended, from the front-end user interface to the server-side back-end functionality. In addition, end-to-end tests can help catch issues that may not be apparent in unit or integration tests by testing the entire application flow.

One of the primary benefits of end-to-end testing is that it helps improve the overall quality of the web application. By testing the entire application flow, developers can identify and fix issues early on before they become significant problems that impact the user experience. End-to-end tests can also help ensure that new features or changes to existing features do not introduce regressions that negatively affect the user experience.

End-to-end testing can also help reduce the risk of downtime or data loss. End-to-end tests can help prevent costly downtime and data loss by catching issues before they impact production environments. Additionally, end-to-end tests can help ensure that the application is working as expected after updates or changes to the infrastructure, such as deploying to a new server or upgrading to a recent version of a framework or library.

Overall, writing end-to-end tests for web applications is critical to ensuring the application's quality and reliability. By testing the entire application flow, developers can catch issues early on and reduce the risk of downtime or data loss. Additionally, end-to-end tests can help improve the overall user experience by ensuring the application works as expected.

## Usage

### Adding Cypress to your Rails project

In order to not delay the decision to adopt Cypress, the automated Rails initialisation tooling will be added later. For now, please follow the [cypress-rails](https://github.com/testdouble/cypress-rails) instructions.

For information on using cypress, visit <https://github.com/testdouble/cypress-rails#usage>.

### Adding Cypress to other projects

To add Cypress to non-Rails projects, please follow the official instructions on [installing Cypress](https://docs.cypress.io/guides/getting-started/installing-cypress).

### Writing tests

The Cypress documentation is excellent, but here are a few good starting points:

* [Writing Your First End-to-End Test](https://docs.cypress.io/guides/end-to-end-testing/writing-your-first-end-to-end-test)
* [Introduction to Cypress](https://docs.cypress.io/guides/core-concepts/introduction-to-cypress)
* [Best Practices](https://docs.cypress.io/guides/references/best-practices)
