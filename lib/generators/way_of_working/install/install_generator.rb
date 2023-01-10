module WayOfWorking
  # This generator installs HDI ways of working into this Rails project
  class InstallGenerator < Rails::Generators::Base
    def add_rake_tasks_Rakefile
      inject_into_file 'Rakefile',
                        "require 'way_of_working/tasks' if Rails.env.development? || Rails.env.test?\n",
                        after: "require_relative \"config/application\"\n"
    end

    # TODO: Run individual installers
  end
end
