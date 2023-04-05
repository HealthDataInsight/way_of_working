# frozen_string_literal: true

require 'way_of_working/paths'

module WayOfWorking
  module Generators
    module AppServer
      # This class generates the cypress GitHub workflow
      class Rails < Thor::Group
        include Thor::Actions

        argument :file_name, type: :string
        source_root ::WayOfWorking.source_root

        CI_DATABASE_CONFIG_FILE = 'config/database.yml.ci'

        DATABASE_ENV_VARIABLE =
          "      DATABASE_URL: postgres://rails:password@localhost:5432/rails_test?pool=5\n"
        RAILS_ENV_VARIABLES = <<-RUBY
      RACK_MINI_PROFILER: off
      RAILS_ENV: test
      RAILS_MASTER_KEY: ${{ secrets.RAILS_MASTER_KEY }}
        RUBY

        # Do we need to use image: postgres:11-alpine
        POSTGRES_SERVICE = <<-RUBY
      postgres:
        env:
          POSTGRES_DB: rails_test
          POSTGRES_PASSWORD: password
          POSTGRES_USER: rails
        image: postgres
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
          --name postgres
        ports:
          - 5432:5432
        RUBY

        RUBY_STEPS_WITHOUT_CACHE = <<-RUBY
      - name: Setup Ruby
        uses: ruby/setup-ruby@ee2113536afb7f793eed4ce60e8d3b26db912da4  # v1.127.0
      # bundler-cache doesn't work with a working-directory
      - name: Install gems
        run: |
          bundle install
        RUBY

        RUBY_STEPS_WITH_CACHE = <<-RUBY
      - name: Set up Ruby + Bundle
      uses: ruby/setup-ruby@v1
      with:
        bundler-cache: true
        ruby-version: ${{ matrix.ruby-version }}
        RUBY

        DATABASE_STEPS = <<-RUBY
      - name: Inject configuration
      run: cp config/database.yml{.ci,}
      # Add or replace database setup steps here
      - name: Set up test database
        run: |
          bin/rails db:schema:load
          bin/rails db:setup
        RUBY

        FINAL_STEPS = <<-RUBY
      - name: Build assets
        run: |
          yarn install --pure-lockfile
          bundle exec rails assets:precompile
      #     bundle exec rails css:build javascript:build
      - name: Start server in the background
        run: |
          bundle exec rails server &
          sleep 5
        RUBY

        def add_env_variables_to_workflow
          env_variables = RAILS_ENV_VARIABLES
          env_variables = DATABASE_ENV_VARIABLE + env_variables
          inject_into_file file_name, env_variables, after: /^\s{4}env:\n/
        end

        def add_database_service_to_workflow
          return unless database_configured?

          inject_into_file file_name, POSTGRES_SERVICE, after: /^\s{4}services:\n/

          # class_option :test_framework, type: :string
          # invoke_from_option :app_type
        end

        def add_server_steps_to_workflow
          server_steps = RUBY_STEPS_WITHOUT_CACHE
          server_steps += DATABASE_STEPS if database_configured?
          server_steps += FINAL_STEPS

          inject_into_file file_name, server_steps, after: "## START: App Server Steps\n"
        end

        def create_ci_database_config_file
          return unless database_configured?

          case behavior
          when :invoke
            copy_file CI_DATABASE_CONFIG_FILE
          when :revoke
            revoke_ci_database_config_file
          end
        end

        private

        def database_configured?
          File.exist?('config/database.yml')
        end

        def revoke_ci_database_config_file
          path = File.expand_path(CI_DATABASE_CONFIG_FILE, destination_root)

          say_status :remove, relative_to_original_destination_root(path)
          return unless !options[:pretend] && (File.exist?(path) || File.symlink?(path))

          require 'fileutils'
          ::FileUtils.rm_rf(path)
        end
      end
    end
  end
end
