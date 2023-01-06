module WayOfWorking
  module DecisionRecord
    # This generator add the MADR files to the doc/decisions folder
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      # Templates are from https://github.com/adr/madr/tree/3.0.0/template
      def create_decision_record_files
        template 'docs/decisions/README.md'

        # from https://raw.githubusercontent.com/adr/madr/3.0.0/template/adr-template.md
        @decision_date = '{YYYY-MM-DD when the decision was last updated}'
        template 'docs/decisions/adr-template.md'

        get 'https://raw.githubusercontent.com/adr/madr/3.0.0/template/0000-use-markdown-any-decision-records.md',
            'docs/decisions/0000-use-markdown-any-decision-records.md'
      end

      protected

        def project_name
          # Rails <= 6.0
          return Rails.application.class.parent_name if Rails.application.class.method_defined?(:parent_name)

          # Rails 6.1 and higher
          Rails.application.class.module_parent_name
        end
    end
  end
end
