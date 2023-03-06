---
has_children: true
layout: page
---

# Code Linting

We use [MegaLinter](https://megalinter.io/) for the majority of our code lining.

Code linters like MegaLinter benefit developers and teams because they help improve code quality, reduce errors and inconsistencies, and streamline development. Linters analyze source code for common issues, such as syntax errors, undefined variables, and unused code, and provide suggestions and feedback for improvement.

Using a linter like MegaLinter, developers can catch and fix errors early in the development process, saving time and effort in the long run. The linter also provides consistency in the codebase, helping to prevent errors caused by different team members using different styles or approaches, which can be especially valuable for large projects with many contributors or where you want staff to be able to switch between projects more efficiently.

MegaLinter is a particularly powerful linter because it supports multiple programming languages, making it a one-stop shop for developers working on projects with various languages.

{: .note }
We have chosen not to use the version of [RuboCop](https://rubocop.org) packaged in MegaLinter because it can't support our use of Minitest and Rails "cops". But by using our CLI command to run linting, as documented below, both RuboCop and MegaLinter will be executed against your code.

When you add the Way of Working linter to your project, it will copy our per-language organisational code styles (where they differ from defaults) into `.github/linters` and will copy the GitHub Actions workflow files into `.github/workflow`, so that linting automatically runs when you commit to GitHub. 

{: .important }
If you disagree with any of the linters or linting styles that they apply, please fork the repository and create a pull request with your desired changes. The current coding standards are only intended as a starting point. A Full list of the linters we are currently using can be found [here](linters.md).

## Usage

To add [MegaLinter](https://megalinter.io/) and [RuboCop](https://rubocop.org) to your project, run the following at the command line:

    way_of_working init linter

to run MegaLinter in your project, run:

    way_of_working exec linter
