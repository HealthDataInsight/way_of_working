---
layout: page
nav_order: 1
parent: Code Linting
---

# Linters

The following tables detail the linters that we are currently using:

## Languages

| Language     | Linter                                | Details                                                                     |
|:-------------|:--------------------------------------|:----------------------------------------------------------------------------|
| Bash         | BASH_EXEC                             | [bash-exec](https://megalinter.io/latest/descriptors/bash_bash_exec/)       |
| Bash         | BASH_SHELLCHECK                       | [shellcheck](https://megalinter.io/latest/descriptors/bash_shellcheck/)     |
| Bash         | BASH_SHFMT                            | [shfmt](https://megalinter.io/latest/descriptors/bash_shfmt/)               |
| C            | C_CLANG_FORMAT                        | [clang-format](https://megalinter.io/latest/descriptors/c_clang_format/)    |
| C            | C_CPPCHECK                            | [cppcheck](https://megalinter.io/latest/descriptors/c_cppcheck/)            |
| C            | C_CPPLINT                             | [cpplint](https://megalinter.io/latest/descriptors/c_cpplint/)              |
| C#           | ~~CSHARP_CSHARPIER~~                  | Not Used                                                                    |
| C#           | ~~CSHARP_DOTNET_FORMAT~~              | Not Used                                                                    |
| C#           | ~~CSHARP_ROSLYNATOR~~                 | Not Used                                                                    |
| C++          | CPP_CLANG_FORMAT                      | [clang-format](https://megalinter.io/latest/descriptors/cpp_clang_format/)  |
| C++          | CPP_CPPCHECK                          | [cppcheck](https://megalinter.io/latest/descriptors/cpp_cppcheck/)          |
| C++          | CPP_CPPLINT                           | [cpplint](https://megalinter.io/latest/descriptors/cpp_cpplint/)            |
| Clojure      | ~~CLOJURE_CLJSTYLE~~                  | Not Used                                                                    |
| Clojure      | ~~CLOJURE_CLJ_KONDO~~                 | Not Used                                                                    |
| CoffeeScript | ~~COFFEE_COFFEELINT~~                 | Not Used                                                                    |
| Dart         | ~~DART_DARTANALYZER~~                 | Not Used                                                                    |
| Go           | ~~GO_GOLANGCI_LINT~~                  | Not Used                                                                    |
| Go           | ~~GO_REVIVE~~                         | Not Used                                                                    |
| Groovy       | ~~GROOVY_NPM_GROOVY_LINT~~            | Not Used                                                                    |
| Java         | ~~JAVA_CHECKSTYLE~~                   | Not Used                                                                    |
| Java         | ~~JAVA_PMD~~                          | Not Used                                                                    |
| JavaScript   | ~~JAVASCRIPT_BIOME~~                  | Not Used                                                                    |
| JavaScript   | JAVASCRIPT_ES                         | [eslint](https://megalinter.io/latest/descriptors/javascript_eslint/)       |
| JavaScript   | ~~JAVASCRIPT_PRETTIER~~               | Not Used                                                                    |
| JavaScript   | ~~JAVASCRIPT_STANDARD~~               | Not Used                                                                    |
| JSX          | ~~JSX_BIOME~~                         | Not Used                                                                    |
| JSX          | ~~JSX_ESLINT~~                        | Not Used                                                                    |
| Kotlin       | KOTLIN_DETEKT                         | [detekt](https://megalinter.io/latest/descriptors/kotlin_detekt/)           |
| Kotlin       | KOTLIN_KTLINT                         | [ktlint](https://megalinter.io/latest/descriptors/kotlin_ktlint/)           |
| Lua          | ~~LUA_LUACHECK~~                      | Not Used                                                                    |
| Lua          | ~~LUA_STYLUA~~                        | Not Used                                                                    |
| Perl         | ~~PERL_PERLCRITIC~~                   | Not Used                                                                    |
| PHP          | ~~PHP_PHPCS~~                         | Not Used                                                                    |
| PHP          | ~~PHP_PHPCSFIXER~~                    | Not Used                                                                    |
| PHP          | ~~PHP_PHPLINT~~                       | Not Used                                                                    |
| PHP          | ~~PHP_PHPSTAN~~                       | Not Used                                                                    |
| PHP          | ~~PHP_PSALM~~                         | Not Used                                                                    |
| Powershell   | ~~POWERSHELL_POWERSHELL~~             | Not Used                                                                    |
| Powershell   | ~~POWERSHELL_POWERSHELL_FORMATTER~~   | Not Used                                                                    |
| Python       | PYTHON_BANDIT                         | [bandit](https://megalinter.io/latest/descriptors/python_bandit/)           |
| Python       | PYTHON_BLACK                          | [black](https://megalinter.io/latest/descriptors/python_black/)             |
| Python       | PYTHON_FLAKE8                         | [flake8](https://megalinter.io/latest/descriptors/python_flake8/)           |
| Python       | PYTHON_ISORT                          | [isort](https://megalinter.io/latest/descriptors/python_isort/)             |
| Python       | PYTHON_MYPY                           | [mypy](https://megalinter.io/latest/descriptors/python_mypy/)               |
| Python       | ~~PYTHON_NBQA_MYPY~~                  | Not Used                                                                    |
| Python       | PYTHON_PYLINT                         | [pylint](https://megalinter.io/latest/descriptors/python_pylint/)           |
| Python       | PYTHON_PYRIGHT                        | [pyright](https://megalinter.io/latest/descriptors/python_pyright/)         |
| Python       | PYTHON_RUFF                           | [ruff](https://megalinter.io/latest/descriptors/python_ruff/)               |
| Python       | PYTHON_RUFF_FORMAT                    | [ruff-format](https://megalinter.io/latest/descriptors/python_ruff_format/) |
| R            | R_LINTR                               | [lintr](https://megalinter.io/latest/descriptors/r_lintr/)                  |
| Raku         | ~~RAKU_RAKU~~                         | Not Used                                                                    |
| Ruby         | ~~RUBY_RUBOCOP~~                      | Not Used (RuboCop is used directly)                                         |
| Rust         | ~~RUST_CLIPPY~~                       | Not Used                                                                    |
| Salesforce   | ~~SALESFORCE_CODE_ANALYZER_APEX~~     | Not Used                                                                    |
| Salesforce   | ~~SALESFORCE_CODE_ANALYZER_APEXGURU~~ | Not Used                                                                    |
| Salesforce   | ~~SALESFORCE_CODE_ANALYZER_AURA~~     | Not Used                                                                    |
| Salesforce   | ~~SALESFORCE_CODE_ANALYZER_FLOW~~     | Not Used                                                                    |
| Salesforce   | ~~SALESFORCE_CODE_ANALYZER_LWC~~      | Not Used                                                                    |
| Scala        | ~~SCALA_SCALAFIX~~                    | Not Used                                                                    |
| SQL          | SQL_SQLFLUFF                          | [sqlfluff](https://megalinter.io/latest/descriptors/sql_sqlfluff/)          |
| Swift        | SWIFT_SWIFTLINT                       | [swiftlint](https://megalinter.io/latest/descriptors/swift_swiftlint/)      |
| TSX          | ~~TSX_BIOME~~                         | Not Used                                                                    |
| TSX          | ~~TSX_ESLINT~~                        | Not Used                                                                    |
| TypeScript   | ~~TYPESCRIPT_BIOME~~                  | Not Used                                                                    |
| TypeScript   | ~~TYPESCRIPT_ES~~                     | Not Used                                                                    |
| TypeScript   | ~~TYPESCRIPT_PRETTIER~~               | Not Used                                                                    |
| TypeScript   | ~~TYPESCRIPT_STANDARD~~               | Not Used                                                                    |
| VB.Net       | ~~VBDOTNET_DOTNET_FORMAT~~            | Not Used                                                                    |

## Formats

| Format           | Linter                            | Details                                                                                                 |
|:-----------------|:----------------------------------|:--------------------------------------------------------------------------------------------------------|
| CSS              | ~~CSS_BIOME~~                     | Not Used                                                                                                |
| CSS              | CSS_STYLELINT                     | [stylelint](https://megalinter.io/latest/descriptors/css_stylelint/)                                    |
| ENV              | ENV_DOTENV_LINTER                 | [dotenv-linter](https://megalinter.io/latest/descriptors/env_dotenv_linter/)                            |
| GraphQL          | ~~GRAPHQL_BIOME~~                 | Not Used                                                                                                |
| GraphQL          | GRAPHQL_GRAPHQL_SCHEMA_LINTER     | [graphql-schema-linter](https://megalinter.io/latest/descriptors/graphql_graphql_schema_linter/)        |
| HTML             | HTML_DJLINT                       | [djlint](https://megalinter.io/latest/descriptors/html_djlint/)                                         |
| HTML             | HTML_HTMLHINT                     | [htmlhint](https://megalinter.io/latest/descriptors/html_htmlhint/)                                     |
| JSON             | ~~JSON_BIOME~~                    | Not Used                                                                                                |
| JSON             | JSON_JSONLINT                     | [jsonlint](https://megalinter.io/latest/descriptors/json_jsonlint/)                                     |
| JSON             | JSON_NPM_PACKAGE_JSON_LINT        | [npm-package-json-lint](https://megalinter.io/latest/descriptors/json_npm_package_json_lint/)           |
| JSON             | JSON_PRETTIER                     | [prettier](https://megalinter.io/latest/descriptors/json_prettier/)                                     |
| JSON             | JSON_V8R                          | [v8r](https://megalinter.io/latest/descriptors/json_v8r/)                                               |
| LaTeX            | ~~LATEX_CHKTEX~~                  | Not Used                                                                                                |
| Markdown         | MARKDOWN_MARKDOWNLINT             | [markdownlint](https://megalinter.io/latest/descriptors/markdown_markdownlint/)                         |
| Markdown         | MARKDOWN_MARKDOWN_TABLE_FORMATTER | [markdown-table-formatter](https://megalinter.io/latest/descriptors/markdown_markdown_table_formatter/) |
| Markdown         | ~~MARKDOWN_RUMDL~~                | Not Used                                                                                                |
| Protocol Buffers | PROTOBUF_PROTOLINT                | [protolint](https://megalinter.io/latest/descriptors/protobuf_protolint/)                               |
| reStructuredText | ~~RST_RSTCHECK~~                  | Not Used                                                                                                |
| reStructuredText | ~~RST_RSTFMT~~                    | Not Used                                                                                                |
| reStructuredText | ~~RST_RST_LINT~~                  | Not Used                                                                                                |
| XML              | XML_XMLLINT                       | [xmllint](https://megalinter.io/latest/descriptors/xml_xmllint/)                                        |
| YAML             | YAML_PRETTIER                     | [prettier](https://megalinter.io/latest/descriptors/yaml_prettier/)                                     |
| YAML             | YAML_V8R                          | [v8r](https://megalinter.io/latest/descriptors/yaml_v8r/)                                               |
| YAML             | YAML_YAMLLINT                     | [yamllint](https://megalinter.io/latest/descriptors/yaml_yamllint/)                                     |

## Tooling formats

| Tooling format | Linter                                | Details                                                                            |
|:---------------|:--------------------------------------|:-----------------------------------------------------------------------------------|
| GitHub Action  | ACTION_ACTIONLINT                     | [actionlint](https://megalinter.io/latest/descriptors/action_actionlint/)          |
| GitHub Action  | ~~ACTION_ZIZMOR~~                     | Not Used                                                                           |
| Ansible        | ~~ANSIBLE_ANSIBLE_LINT~~              | Not Used                                                                           |
| Api            | API_SPECTRAL                          | [spectral](https://megalinter.io/latest/descriptors/api_spectral/)                 |
| ARM Templates  | ARM_ARM_TTK                           | [arm-ttk](https://megalinter.io/latest/descriptors/arm_arm_ttk/)                   |
| Bicep          | BICEP_BICEP_LINTER                    | [bicep_linter](https://megalinter.io/latest/descriptors/bicep_bicep_linter/)       |
| CloudFormation | CLOUDFORMATION_CFN_LINT               | [cfn-lint](https://megalinter.io/latest/descriptors/cloudformation_cfn_lint/)      |
| Dockerfile     | DOCKERFILE_HADOLINT                   | [hadolint](https://megalinter.io/latest/descriptors/dockerfile_hadolint/)          |
| EditorConfig   | ~~EDITORCONFIG_EDITORCONFIG_CHECKER~~ | Not Used                                                                           |
| Gherkin        | GHERKIN_GHERKIN_LINT                  | [gherkin-lint](https://megalinter.io/latest/descriptors/gherkin_gherkin_lint/)     |
| Kubernetes     | ~~KUBERNETES_HELM~~                   | Not Used                                                                           |
| Kubernetes     | ~~KUBERNETES_KUBECONFORM~~            | Not Used                                                                           |
| Kubernetes     | ~~KUBERNETES_KUBESCAPE~~              | Not Used                                                                           |
| Robotframework | ~~ROBOTFRAMEWORK_ROBOCOP~~            | Not Used                                                                           |
| Snakemake      | ~~SNAKEMAKE_LINT~~                    | Not Used                                                                           |
| Snakemake      | ~~SNAKEMAKE_SNAKEFMT~~                | Not Used                                                                           |
| Tekton         | ~~TEKTON_TEKTON_LINT~~                | Not Used                                                                           |
| Terraform      | TERRAFORM_TERRAFORM_FMT               | [terraform-fmt](https://megalinter.io/latest/descriptors/terraform_terraform_fmt/) |
| Terraform      | TERRAFORM_TERRAGRUNT                  | [terragrunt](https://megalinter.io/latest/descriptors/terraform_terragrunt/)       |
| Terraform      | TERRAFORM_TFLINT                      | [tflint](https://megalinter.io/latest/descriptors/terraform_tflint/)               |
| Terraform      | ~~TERRAFORM_TOFU_FMT~~                | Not Used                                                                           |
| Terraform      | ~~TERRAFORM_TOFU_VALIDATE~~           | Not Used                                                                           |

## Other

| Other      | Linter                     | Details                                                                       |
|:-----------|:---------------------------|:------------------------------------------------------------------------------|
| Copypaste  | COPYPASTE_JSCPD            | [jscpd](https://megalinter.io/latest/descriptors/copypaste_jscpd/)            |
| Repository | ~~REPOSITORY_BETTERLEAKS~~ | Not Used                                                                      |
| Repository | REPOSITORY_CHECKOV         | [checkov](https://megalinter.io/latest/descriptors/repository_checkov/)       |
| Repository | REPOSITORY_DEVSKIM         | [devskim](https://megalinter.io/latest/descriptors/repository_devskim/)       |
| Repository | REPOSITORY_DUSTILOCK       | [dustilock](https://megalinter.io/latest/descriptors/repository_dustilock/)   |
| Repository | REPOSITORY_GIT_DIFF        | [git_diff](https://megalinter.io/latest/descriptors/repository_git_diff/)     |
| Repository | REPOSITORY_GRYPE           | [grype](https://megalinter.io/latest/descriptors/repository_grype/)           |
| Repository | ~~REPOSITORY_KINGFISHER~~  | Not Used                                                                      |
| Repository | REPOSITORY_LS_LINT         | [ls-lint](https://megalinter.io/latest/descriptors/repository_ls_lint/)       |
| Repository | ~~REPOSITORY_OSV_SCANNER~~ | Not Used                                                                      |
| Repository | REPOSITORY_SECRETLINT      | [secretlint](https://megalinter.io/latest/descriptors/repository_secretlint/) |
| Repository | REPOSITORY_SEMGREP         | [semgrep](https://megalinter.io/latest/descriptors/repository_semgrep/)       |
| Repository | REPOSITORY_SYFT            | [syft](https://megalinter.io/latest/descriptors/repository_syft/)             |
| Repository | REPOSITORY_TRIVY           | [trivy](https://megalinter.io/latest/descriptors/repository_trivy/)           |
| Repository | REPOSITORY_TRIVY_SBOM      | [trivy-sbom](https://megalinter.io/latest/descriptors/repository_trivy_sbom/) |
| Repository | REPOSITORY_TRUFFLEHOG      | [trufflehog](https://megalinter.io/latest/descriptors/repository_trufflehog/) |
| Spelling   | ~~SPELL_CODESPELL~~        | Not Used                                                                      |
| Spelling   | ~~SPELL_CSPELL~~           | Not Used                                                                      |
| Spelling   | SPELL_LYCHEE               | [lychee](https://megalinter.io/latest/descriptors/spell_lychee/)              |
| Spelling   | SPELL_PROSELINT            | [proselint](https://megalinter.io/latest/descriptors/spell_proselint/)        |
| Spelling   | SPELL_VALE                 | [vale](https://megalinter.io/latest/descriptors/spell_vale/)                  |
