# frozen_string_literal: true

require_relative 'base'

module WayOfWorking
  module SubCommands
    # This class defines the "init" parent command
    class Init < Base
      desc 'all --contact-method [CONTACT METHOD]',
           'This adds all of the available Way of Working components to this project'
      method_option :contact_method, required: true
      def all
        invoke_all
      end
    end
  end
end
