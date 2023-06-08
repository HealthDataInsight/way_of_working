---
layout: page
nav_order: 1
parent: Code Linting
---

# Linters

The following tables detail the linters that we are currently using:

## Languages

| Language     | Linter                              | Details                                                                         |
|:-------------|:------------------------------------|:--------------------------------------------------------------------------------|
| Bash         | BASH_EXEC                           | [bash-exec](https://megalinter.io/latest/descriptors/bash_bash_exec/)           |
| Bash         | BASH_SHELLCHECK                     | [shellcheck](https://megalinter.io/latest/descriptors/bash_shellcheck/)         |
| Bash         | BASH_SHFMT                          | [shfmt](https://megalinter.io/latest/descriptors/bash_shfmt/)                   |
| C            | C_CPPLINT                           | [cpplint](https://megalinter.io/latest/descriptors/c_cpplint/)                  |
| C#           | ~~CSHARP_CSHARPIER~~                | Not Used                                                                        |
| C#           | CSHARP_DOTNET_FORMAT                | [dotnet-format](https://megalinter.io/latest/descriptors/csharp_dotnet_format/) |
| C++          | CPP_CPPLINT                         | [cpplint](https://megalinter.io/latest/descriptors/cpp_cpplint/)                |
| Clojure      | ~~CLOJURE_CLJSTYLE~~                | Not Used                                                                        |
| Clojure      | ~~CLOJURE_CLJ_KONDO~~               | Not Used                                                                        |
| CoffeeScript | COFFEE_COFFEELINT                   | [coffeelint](https://megalinter.io/latest/descriptors/coffee_coffeelint/)       |
| Dart         | DART_DARTANALYZER                   | [dartanalyzer](https://megalinter.io/latest/descriptors/dart_dartanalyzer/)     |
| Go           | GO_GOLANGCI_LINT                    | [golangci-lint](https://megalinter.io/latest/descriptors/go_golangci_lint/)     |
| Go           | GO_REVIVE                           | [revive](https://megalinter.io/latest/descriptors/go_revive/)                   |
| Groovy       | ~~GROOVY_NPM_GROOVY_LINT~~          | Not Used                                                                        |
| Java         | JAVA_CHECKSTYLE                     | [checkstyle](https://megalinter.io/latest/descriptors/java_checkstyle/)         |
| Java         | JAVA_PMD                            | [pmd](https://megalinter.io/latest/descriptors/java_pmd/)                       |
| JavaScript   | JAVASCRIPT_ES                       | [eslint](https://megalinter.io/latest/descriptors/javascript_eslint/)           |
| JavaScript   | ~~JAVASCRIPT_PRETTIER~~             | Not Used                                                                        |
| JavaScript   | JAVASCRIPT_STANDARD                 | [standard](https://megalinter.io/latest/descriptors/javascript_standard/)       |
| JSX          | JSX_ESLINT                          | [eslint](https://megalinter.io/latest/descriptors/jsx_eslint/)                  |
| Kotlin       | KOTLIN_KTLINT                       | [ktlint](https://megalinter.io/latest/descriptors/kotlin_ktlint/)               |
| Lua          | ~~LUA_LUACHECK~~                    | Not Used                                                                        |
| Makefile     | MAKEFILE_CHECKMAKE                  | [checkmake](https://megalinter.io/latest/descriptors/makefile_checkmake/)       |
| Perl         | ~~PERL_PERLCRITIC~~                 | Not Used                                                                        |
| PHP          | ~~PHP_PHPCS~~                       | Not Used                                                                        |
| PHP          | ~~PHP_PHPLINT~~                     | Not Used                                                                        |
| PHP          | ~~PHP_PHPSTAN~~                     | Not Used                                                                        |
| PHP          | ~~PHP_PSALM~~                       | Not Used                                                                        |
| Powershell   | ~~POWERSHELL_POWERSHELL~~           | Not Used                                                                        |
| Powershell   | ~~POWERSHELL_POWERSHELL_FORMATTER~~ | Not Used                                                                        |
| Python       | PYTHON_BANDIT                       | [bandit](https://megalinter.io/latest/descriptors/python_bandit/)               |
| Python       | PYTHON_BLACK                        | [black](https://megalinter.io/latest/descriptors/python_black/)                 |
| Python       | PYTHON_FLAKE8                       | [flake8](https://megalinter.io/latest/descriptors/python_flake8/)               |
| Python       | PYTHON_ISORT                        | [isort](https://megalinter.io/latest/descriptors/python_isort/)                 |
| Python       | PYTHON_MYPY                         | [mypy](https://megalinter.io/latest/descriptors/python_mypy/)                   |
| Python       | PYTHON_PYLINT                       | [pylint](https://megalinter.io/latest/descriptors/python_pylint/)               |
| Python       | PYTHON_PYRIGHT                      | [pyright](https://megalinter.io/latest/descriptors/python_pyright/)             |
| Python       | ~~PYTHON_RUFF~~                     | Not Used                                                                        |
| R            | R_LINTR                             | [lintr](https://megalinter.io/latest/descriptors/r_lintr/)                      |
| Raku         | ~~RAKU_RAKU~~                       | Not Used                                                                        |
| Ruby         | ~~RUBY_RUBOCOP~~                    | Not Used (RuboCop is used directly)                                             |
| Rust         | RUST_CLIPPY                         | [clippy](https://megalinter.io/latest/descriptors/rust_clippy/)                 |
| Salesforce   | ~~SALESFORCE_SFDX_SCANNER_APEX~~    | Not Used                                                                        |
| Salesforce   | ~~SALESFORCE_SFDX_SCANNER_AURA~~    | Not Used                                                                        |
| Salesforce   | ~~SALESFORCE_SFDX_SCANNER_LWC~~     | Not Used                                                                        |
| Scala        | SCALA_SCALAFIX                      | [scalafix](https://megalinter.io/latest/descriptors/scala_scalafix/)            |
| SQL          | SQL_SQLFLUFF                        | [sqlfluff](https://megalinter.io/latest/descriptors/sql_sqlfluff/)              |
| SQL          | SQL_SQL_LINT                        | [sql-lint](https://megalinter.io/latest/descriptors/sql_sql_lint/)              |
| SQL          | SQL_TSQLLINT                        | [tsqllint](https://megalinter.io/latest/descriptors/sql_tsqllint/)              |
| Swift        | SWIFT_SWIFTLINT                     | [swiftlint](https://megalinter.io/latest/descriptors/swift_swiftlint/)          |
| TSX          | TSX_ESLINT                          | [eslint](https://megalinter.io/latest/descriptors/tsx_eslint/)                  |
| TypeScript   | TYPESCRIPT_ES                       | [eslint](https://megalinter.io/latest/descriptors/typescript_eslint/)           |
| TypeScript   | ~~TYPESCRIPT_PRETTIER~~             | Not Used                                                                        |
| TypeScript   | TYPESCRIPT_STANDARD                 | [standard](https://megalinter.io/latest/descriptors/typescript_standard/)       |
| VB.Net       | ~~VBDOTNET_DOTNET_FORMAT~~          | Not Used                                                                        |

## Formats

| Format           | Linter                            | Details                                                                                                 |
|:-----------------|:----------------------------------|:--------------------------------------------------------------------------------------------------------|
| CSS              | ~~CSS_SCSS_LINT~~                 | Not Used (scss-lint recommends using stylelint)                                                         |
| CSS              | CSS_STYLELINT                     | [stylelint](https://megalinter.io/latest/descriptors/css_stylelint/)                                    |
| ENV              | ENV_DOTENV_LINTER                 | [dotenv-linter](https://megalinter.io/latest/descriptors/env_dotenv_linter/)                            |
| GraphQL          | ~~GRAPHQL_GRAPHQL_SCHEMA_LINTER~~ | Not Used                                                                                                |
| HTML             | ~~HTML_DJLINT~~                   | Not Used (Refuses to see config file)                                                                   |
| HTML             | HTML_HTMLHINT                     | [htmlhint](https://megalinter.io/latest/descriptors/html_htmlhint/)                                     |
| JSON             | JSON_ESLINT_PLUGIN_JSONC          | [eslint-plugin-jsonc](https://megalinter.io/latest/descriptors/json_eslint_plugin_jsonc/)               |
| JSON             | JSON_JSONLINT                     | [jsonlint](https://megalinter.io/latest/descriptors/json_jsonlint/)                                     |
| JSON             | JSON_NPM_PACKAGE_JSON_LINT        | [npm-package-json-lint](https://megalinter.io/latest/descriptors/json_npm_package_json_lint/)           |
| JSON             | ~~JSON_PRETTIER~~                 | Not Used                                                                                                |
| JSON             | JSON_V8R                          | [v8r](https://megalinter.io/latest/descriptors/json_v8r/)                                               |
| LaTeX            | ~~LATEX_CHKTEX~~                  | Not Used                                                                                                |
| Markdown         | MARKDOWN_MARKDOWNLINT             | [markdownlint](https://megalinter.io/latest/descriptors/markdown_markdownlint/)                         |
| Markdown         | MARKDOWN_MARKDOWN_LINK_CHECK      | [markdown-link-check](https://megalinter.io/latest/descriptors/markdown_markdown_link_check/)           |
| Markdown         | MARKDOWN_MARKDOWN_TABLE_FORMATTER | [markdown-table-formatter](https://megalinter.io/latest/descriptors/markdown_markdown_table_formatter/) |
| Markdown         | MARKDOWN_REMARK_LINT              | [remark-lint](https://megalinter.io/latest/descriptors/markdown_remark_lint/)                           |
| Protocol Buffers | ~~PROTOBUF_PROTOLINT~~            | Not Used                                                                                                |
| reStructuredText | ~~RST_RSTCHECK~~                  | Not Used                                                                                                |
| reStructuredText | ~~RST_RSTFMT~~                    | Not Used                                                                                                |
| reStructuredText | ~~RST_RST_LINT~~                  | Not Used                                                                                                |
| XML              | XML_XMLLINT                       | [xmllint](https://megalinter.io/latest/descriptors/xml_xmllint/)                                        |
| YAML             | ~~YAML_PRETTIER~~                 | Not Used                                                                                                |
| YAML             | YAML_V8R                          | [v8r](https://megalinter.io/latest/descriptors/yaml_v8r/)                                               |
| YAML             | YAML_YAMLLINT                     | [yamllint](https://megalinter.io/latest/descriptors/yaml_yamllint/)                                     |

## Tooling formats

| Tooling format | Linter                            | Details                                                                                             |
|:---------------|:----------------------------------|:----------------------------------------------------------------------------------------------------|
| GitHub Action  | ACTION_ACTIONLINT                 | [actionlint](https://megalinter.io/latest/descriptors/action_actionlint/)                           |
| Ansible        | ANSIBLE_ANSIBLE_LINT              | [ansible-lint](https://megalinter.io/latest/descriptors/ansible_ansible_lint/)                      |
| ARM Templates  | ARM_ARM_TTK                       | [arm-ttk](https://megalinter.io/latest/descriptors/arm_arm_ttk/)                                    |
| Bicep          | ~~BICEP_BICEP_LINTER~~            | Not Used                                                                                            |
| CloudFormation | CLOUDFORMATION_CFN_LINT           | [cfn-lint](https://megalinter.io/latest/descriptors/cloudformation_cfn_lint/)                       |
| Dockerfile     | DOCKERFILE_HADOLINT               | [hadolint](https://megalinter.io/latest/descriptors/dockerfile_hadolint/)                           |
| EditorConfig   | EDITORCONFIG_EDITORCONFIG_CHECKER | [editorconfig-checker](https://megalinter.io/latest/descriptors/editorconfig_editorconfig_checker/) |
| Gherkin        | ~~GHERKIN_GHERKIN_LINT~~          | Not Used                                                                                            |
| Kubernetes     | ~~KUBERNETES_HELM~~               | Not Used                                                                                            |
| Kubernetes     | KUBERNETES_KUBECONFORM            | [kubeconform](https://megalinter.io/latest/descriptors/kubernetes_kubeconform/)                     |
| Kubernetes     | ~~KUBERNETES_KUBESCAPE~~          | Not Used                                                                                            |
| Openapi        | OPENAPI_SPECTRAL                  | [spectral](https://megalinter.io/latest/descriptors/openapi_spectral/)                              |
| Puppet         | PUPPET_PUPPET_LINT                | [puppet-lint](https://megalinter.io/latest/descriptors/puppet_puppet_lint/)                         |
| Snakemake      | ~~SNAKEMAKE_LINT~~                | Not Used                                                                                            |
| Snakemake      | ~~SNAKEMAKE_SNAKEFMT~~            | Not Used                                                                                            |
| Tekton         | ~~TEKTON_TEKTON_LINT~~            | Not Used                                                                                            |
| Terraform      | TERRAFORM_TERRAFORM_FMT           | [terraform-fmt](https://megalinter.io/latest/descriptors/terraform_terraform_fmt/)                  |
| Terraform      | TERRAFORM_TERRAGRUNT              | [terragrunt](https://megalinter.io/latest/descriptors/terraform_terragrunt/)                        |
| Terraform      | TERRAFORM_TERRASCAN               | [terrascan](https://megalinter.io/latest/descriptors/terraform_terrascan/)                          |
| Terraform      | TERRAFORM_TFLINT                  | [tflint](https://megalinter.io/latest/descriptors/terraform_tflint/)                                |

## Other

| Other      | Linter                | Details                                                                       |
|:-----------|:----------------------|:------------------------------------------------------------------------------|
| Copypaste  | COPYPASTE_JSCPD       | [jscpd](https://megalinter.io/latest/descriptors/copypaste_jscpd/)            |
| Repository | REPOSITORY_CHECKOV    | [checkov](https://megalinter.io/latest/descriptors/repository_checkov/)       |
| Repository | REPOSITORY_DEVSKIM    | [devskim](https://megalinter.io/latest/descriptors/repository_devskim/)       |
| Repository | REPOSITORY_DUSTILOCK  | [dustilock](https://megalinter.io/latest/descriptors/repository_dustilock/)   |
| Repository | REPOSITORY_GITLEAKS   | [gitleaks](https://megalinter.io/latest/descriptors/repository_gitleaks/)     |
| Repository | REPOSITORY_GIT_DIFF   | [git_diff](https://megalinter.io/latest/descriptors/repository_git_diff/)     |
| Repository | ~~REPOSITORY_KICS~~   | Not Used                                                                      |
| Repository | REPOSITORY_SECRETLINT | [secretlint](https://megalinter.io/latest/descriptors/repository_secretlint/) |
| Repository | REPOSITORY_SEMGREP    | [semgrep](https://megalinter.io/latest/descriptors/repository_semgrep/)       |
| Repository | REPOSITORY_SYFT       | [syft](https://megalinter.io/latest/descriptors/repository_syft/)             |
| Repository | REPOSITORY_TRIVY      | [trivy](https://megalinter.io/latest/descriptors/repository_trivy/)           |
| Spelling   | ~~SPELL_CSPELL~~      | Not Used                                                                      |
| Spelling   | SPELL_PROSELINT       | [proselint](https://megalinter.io/latest/descriptors/spell_proselint/)        |
| Spelling   | ~~SPELL_VALE~~        | Not Used                                                                      |

