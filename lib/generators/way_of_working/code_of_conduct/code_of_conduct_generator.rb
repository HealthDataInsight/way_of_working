class WayOfWorking::CodeOfConductGenerator < Rails::Generators::Base
  class_option :contact_method, required: true

  def get_code_of_conduct
    code_of_conduct_file = 'CODE_OF_CONDUCT.md'

    get 'https://www.contributor-covenant.org/version/2/1/code_of_conduct/code_of_conduct.md',
        code_of_conduct_file
    gsub_file code_of_conduct_file, '[INSERT CONTACT METHOD]', options['contact_method']
  end
end
