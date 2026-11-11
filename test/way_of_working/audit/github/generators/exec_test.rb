# frozen_string_literal: true

require 'test_helper'
require 'way_of_working/audit/github'

module WayOfWorking
  module Audit
    module Github
      module Generators
        class ExecTest < Rails::Generators::TestCase
          tests WayOfWorking::Audit::Github::Generators::Exec
          destination File.expand_path('../../../../../tmp', __dir__)

          setup do
            # Set required environment variables
            ENV['GITHUB_TOKEN'] = 'test_token'
            ENV['GITHUB_ORGANISATION'] = 'test_org'

            # Mock Git operations
            mock_git = mock
            mock_git.stubs(:remotes).returns([
                                               stub(url: 'https://github.com/test_org/test_repo.git')
                                             ])
            Git.stubs(:open).returns(mock_git)
          end

          teardown do
            # Clean up environment variables
            ENV.delete('GITHUB_TOKEN')
            ENV.delete('GITHUB_ORGANISATION')
          end

          test 'generator has all option' do
            assert generator_class.class_options.key?(:all)
            assert_equal :boolean, generator_class.class_options[:all].type
            assert_equal false, generator_class.class_options[:all].default
          end

          test 'generator has topic option' do
            assert generator_class.class_options.key?(:topic)
            assert_equal :string, generator_class.class_options[:topic].type
            assert_nil generator_class.class_options[:topic].default
          end

          test 'generator has public option' do
            assert generator_class.class_options.key?(:public)
            assert_equal :boolean, generator_class.class_options[:public].type
            assert_equal false, generator_class.class_options[:public].default
          end

          test 'generator has fix option' do
            assert generator_class.class_options.key?(:fix)
            assert_equal :boolean, generator_class.class_options[:fix].type
            assert_equal false, generator_class.class_options[:fix].default
          end

          test 'audit_github command exposes generator options to help' do
            assert_equal generator_class.class_options,
                         WayOfWorking::SubCommands::Exec.commands['audit_github'].options
          end

          test 'generator has name option' do
            assert generator_class.class_options.key?(:name)
            assert_equal :array, generator_class.class_options[:name].type
            assert_nil generator_class.class_options[:name].default
          end

          test 'prep_audit passes fix option to auditor when false' do
            Auditor.expects(:new).with('test_token', 'test_org', false).returns(stub(repositories: []))

            build_generator({}).prep_audit
          end

          test 'prep_audit passes fix option to auditor when true' do
            Auditor.expects(:new).with('test_token', 'test_org', true).returns(stub(repositories: []))

            build_generator(fix: true).prep_audit
          end

          test 'filter_all_if_specified filters repositories when all is false' do
            generator = prepped_generator({}, repo('test_repo'), repo('other_repo'))
            generator.stubs(:github_organisation_remotes).returns(['test_repo'])
            generator.filter_all_if_specified

            # Should only include test_repo (from git remotes)
            assert_equal ['test_repo'], repository_names(generator)
          end

          test 'filter_all_if_specified does not filter repositories when all is true' do
            generator = prepped_generator({ all: true }, repo('test_repo'), repo('other_repo'))
            generator.filter_all_if_specified

            assert_equal %w[test_repo other_repo], repository_names(generator)
          end

          test 'filter_by_topic_if_specified filters repositories by topic when topic is specified' do
            generator = prepped_generator({ all: true, topic: 'way-of-working' },
                                          repo('test_repo', topics: %w[way-of-working ruby]),
                                          repo('other_repo', topics: ['python']),
                                          repo('third_repo', topics: ['way-of-working']))
            generator.filter_by_topic_if_specified

            assert_equal %w[test_repo third_repo], repository_names(generator)
          end

          test 'filter_by_visibility_if_specified filters repositories to only public when public is true' do
            generator = prepped_generator({ all: true, public: true },
                                          repo('public_repo', private?: false),
                                          repo('private_repo', private?: true),
                                          repo('another_public_repo', private?: false))
            generator.filter_by_visibility_if_specified

            assert_equal %w[public_repo another_public_repo], repository_names(generator)
          end

          test 'filter_by_name_array_if_specified filters repositories by name when name is specified' do
            generator = prepped_generator({ all: true, name: ['structured_store'] },
                                          repo('structured_store'), repo('other_repo'), repo('another_repo'))
            generator.filter_by_name_array_if_specified

            assert_equal ['structured_store'], repository_names(generator)
          end

          test 'filter_all_if_specified does not filter when name is specified without all' do
            generator = prepped_generator({ name: ['structured_store'] },
                                          repo('structured_store'), repo('other_repo'), repo('test_repo'))
            generator.stubs(:github_organisation_remotes).returns(['test_repo'])
            generator.filter_all_if_specified

            # Should include all repos because --name implies --all
            assert_equal %w[structured_store other_repo test_repo], repository_names(generator)
          end

          test 'filter_by_name_array_if_specified filters repositories by multiple names when multiple names are specified' do
            generator = prepped_generator({ all: true, name: %w[structured_store another_repo] },
                                          repo('structured_store'), repo('other_repo'), repo('another_repo'))
            generator.filter_by_name_array_if_specified

            assert_equal %w[structured_store another_repo], repository_names(generator)
          end

          test 'combines topic and public filters when both are specified' do
            generator = prepped_generator({ all: true, topic: 'way-of-working', public: true },
                                          repo('public_with_topic', private?: false, topics: ['way-of-working']),
                                          repo('private_with_topic', private?: true, topics: ['way-of-working']),
                                          repo('public_without_topic', private?: false, topics: ['other']),
                                          repo('private_without_topic', private?: true, topics: ['other']))
            generator.filter_by_topic_if_specified
            generator.filter_by_visibility_if_specified

            assert_equal ['public_with_topic'], repository_names(generator)
          end

          test 'combines name, topic and public filters when all are specified' do
            generator = prepped_generator({ all: true, name: ['structured_store'], topic: 'way-of-working',
                                            public: true },
                                          repo('structured_store', private?: false, topics: ['way-of-working']),
                                          repo('other_store', private?: true, topics: ['way-of-working']),
                                          repo('structured_store', private?: false, topics: ['other']),
                                          repo('public_with_topic', private?: false, topics: ['way-of-working']))
            generator.filter_by_name_array_if_specified
            generator.filter_by_topic_if_specified
            generator.filter_by_visibility_if_specified

            # Should only include public structured_store with 'way-of-working' topic
            assert_equal ['structured_store'], repository_names(generator)
          end

          private

          def repo(name, **attributes)
            stub(name: name, archived?: false, **attributes)
          end

          def build_generator(options)
            generator = generator_class.new([], options, {})
            generator.instance_variable_set(:@github_token, 'test_token')
            generator.instance_variable_set(:@github_organisation, 'test_org')
            generator
          end

          # Returns a generator that has run prep_audit against an auditor stubbed with these repos
          def prepped_generator(options, *repositories)
            Auditor.stubs(:new).returns(stub(repositories: repositories))
            generator = build_generator(options)
            generator.prep_audit
            generator
          end

          def repository_names(generator)
            generator.instance_variable_get(:@repositories).map(&:name)
          end
        end
      end
    end
  end
end
