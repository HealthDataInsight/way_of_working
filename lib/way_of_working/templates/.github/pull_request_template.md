## What?

{Please write a few concise sentences outlining your changes and their overall impact, avoiding overly technical language. Reference relevant issue tracker tickets, but provide a stand-alone description that doesn’t require more than a few seconds to grasp.

e.g. I've added support for authentication to implement feature X of service Y. It
includes model, table, controller and test. For more background, see ticket #JIRA-123.}

## Why?

{Outlining the business or engineering goals this Pull Request accomplishes is often more important than the "what". For instance, adding an environment variable default value may appear uncomplicated to many. However, if it drastically alters the usage of libraries in your application, an active-voiced explanation is needed to capture the true impact of the change.

e.g. These changes complete the user login and account creation experience. See #JIRA-123 for more information.}

## How?

{While the Pull Request diff illustrates the "how" of your changes, it's crucial to highlight major design decisions like choosing a recursive method over a loop. Explaining your reasoning helps reviewers understand your thought process and enables a more insightful review.

e.g. This includes a migration, model and controller for user authentication. I'm using Devise to do the heavy lifting. I ran Devise migrations and those are included here.}

## Testing?

{Including tests along with code updates is essential as it prevents merging code without tests or failing tests, which could pose risks if overlooked. It's equally important to describe how you've tested harder-to-test code, like infrastructure code, and to communicate any untested conditions or edge cases and their associated risks to the reviewer.}

## Screenshots (optional)

{Screenshots can significantly aid the review process, especially for UI-related changes, by offering before-and-after views. Even for backend code, a snapshot of the outcome, such as a CLI tool output, can be insightful. For infrastructure code, consider including the result of operations like a Terraform plan, preferably in a collapsible section, to avoid cluttering the comment space.

Here’s how to do it in GitHub:
```
<details>
  <summary>Terraform Plan</summary>

  ### After running plan:
</details>
```
}

## Anything Else?

{Consider discussing potential architectural modifications and technical debt while highlighting any challenges or optimisations you have identified.

e.g. Let's consider using a 3rd party authentication provider for this, to offload MFA and other considerations as they arise and the privacy landscape evolves. AWS Cognito is a good option, so is Firebase. I'm happy to start researching this path.
Let's also consider breaking this out into its own service. We can then re-use it or share the accounts with other apps in the future.}
