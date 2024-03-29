# frozen_string_literal: true

require_relative 'generators/changelog/init'
require_relative 'generators/code_of_conduct/init'
require_relative 'generators/decision_record/init'
require_relative 'generators/decision_record/new'
require_relative 'generators/inclusive_language/exec'
require_relative 'generators/inclusive_language/init'
require_relative 'generators/linter/document'
require_relative 'generators/linter/exec'
require_relative 'generators/linter/init'
require_relative 'generators/pr_template/init'
require_relative 'generators/rake_tasks/init'
require_relative 'generators/readme_badge/init'
require_relative 'sub_command_base'

module WayOfWorking
  # This class defines the document parent command
  class Document < SubCommandBase
    register(Generators::Linter::Document, 'linter', 'linter',
             <<~LONGDESC)
               Description:
                   This documents the linter on this project

               Example:
                   way_of_working document linter
             LONGDESC
  end

  # This class defines the exec (i.e. run) parent command
  class Exec < SubCommandBase
    register(Generators::Linter::Exec, 'linter', 'linter',
             <<~LONGDESC)
               Description:
                   This runs the linter on this project

               Example:
                   way_of_working exec linter
             LONGDESC

    register(Generators::InclusiveLanguage::Exec, 'inclusive_language', 'inclusive_language',
             <<~LONGDESC)
               Description:
                   This runs inclusive language tests on this project

               Example:
                   way_of_working exec inclusive_language
             LONGDESC
  end

  # This class defines the "init" parent command
  class Init < SubCommandBase
    desc 'all --contact-method [CONTACT METHOD]',
         'This adds all of the available Way of Working components to this project'
    method_option :contact_method, required: true
    def all
      invoke_all
    end

    register(Generators::Changelog::Init, 'changelog', 'changelog',
             <<~LONGDESC)
               Description:
                   This adds the Keep a Changelog v1.1 changelog to the project

               Example:
                   way_of_working init changelog

                   This will create:
                   CHANGELOG.md
             LONGDESC

    register(Generators::CodeOfConduct::Init, 'code_of_conduct',
             'code_of_conduct --contact-method [CONTACT METHOD]',
             <<~LONGDESC)
               Description:
                   This adds the Contributor Covenant v2.1 code of conduct to the project

               Example:
                   way_of_working init code_of_conduct --contact-method "foo@bar.com"

                   This will create:
                       CODE_OF_CONDUCT.md
             LONGDESC

    register(Generators::DecisionRecord::Init, 'decision_record', 'decision_record',
             <<~LONGDESC)
               Description:
                   This generator adds Markdown Any Decision Records (MADR) to your project

               Example:
                   way_of_working init decision_record

                   This will create:
                       docs/decisions/README.md
                       docs/decisions/adr-template.md
                       docs/decisions/0000-use-markdown-any-decision-records.md
             LONGDESC

    register(Generators::Linter::Init, 'linter', 'linter',
             <<~LONGDESC)
               Description:
                   Installs MegaLinter config files into the project

               Example:
                   way_of_working init linter

                   This will create:
                       .github/workflows/mega-linter.yml
                       .mega-linter.yml
             LONGDESC

    register(Generators::InclusiveLanguage::Init, 'inclusive_language', 'inclusive_language',
             <<~LONGDESC)
               Description:
                   Installs alex config file into the project

               Example:
                   way_of_working init inclusive_language

                   This will create:
                       .alexrc
             LONGDESC

    register(Generators::PrTemplate::Init, 'pr_template', 'pr_template',
             <<~LONGDESC)
               Description:
                   Installs the Pull Request template into the project

               Example:
                   way_of_working init pr_template

                   This will create:
                       .github/pull_request_template.md
             LONGDESC

    register(Generators::RakeTasks::Init, 'rake_tasks', 'rake_tasks',
             <<~LONGDESC)
               Description:
                   Installs Way of Working rake tasks into this project

               Example:
                   way_of_working init rake_tasks

                   This will amend or create:
                       Rakefile
             LONGDESC

    register(Generators::ReadmeBadge::Init, 'readme_badge', 'readme_badge',
             <<~LONGDESC)
               Description:
                   Installs Way of Working readme badge and badge holder into this project

               Example:
                   way_of_working init readme_badge

                   This will amend or create:
                       README.md
             LONGDESC
  end

  # This class defines the "new" parent command
  class New < SubCommandBase
    register(Generators::DecisionRecord::New, 'decision_record', 'decision_record [NAME]',
             <<~LONGDESC)
               Description:
                   This generator adds a new decision record to your project

               Example:
                   way_of_working new decision_record "Title of the decision"

                   This will create:
                       docs/decisions/NNNN-title-of-the-decision.md
             LONGDESC
  end

  # This class defines the top level interface
  class CLI < Thor
    desc 'init [COMPONENT]', 'Initialises Way of Working components'
    subcommand 'init', Init

    desc 'new [THING]', 'Creates new things'
    subcommand 'new', New

    desc 'exec [COMPONENT]', 'Executes (runs) the specific component'
    subcommand 'exec', Exec

    desc 'document [COMPONENT]', 'Documents the specific component'
    subcommand 'document', Document
  end
end
