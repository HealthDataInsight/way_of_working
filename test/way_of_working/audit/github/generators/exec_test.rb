# frozen_string_literal: true

require 'test_helper'

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

          test 'generator has name option' do
            assert generator_class.class_options.key?(:name)
            assert_equal :array, generator_class.class_options[:name].type
            assert_nil generator_class.class_options[:name].default
          end

          test 'prep_audit passes fix option to auditor when false' do
            # Mock the auditor
            mock_auditor = mock
            mock_auditor.stubs(:repositories).returns([])

            # Expect Auditor to be initialized with fix=false
            Auditor.expects(:new).with('test_token', 'test_org', false).returns(mock_auditor)

            # Run generator with fix=false (default)
            generator = generator_class.new([], {}, {})
            generator.instance_variable_set(:@github_token, 'test_token')
            generator.instance_variable_set(:@github_organisation, 'test_org')
            generator.prep_audit
          end

          test 'prep_audit passes fix option to auditor when true' do
            # Mock the auditor
            mock_auditor = mock
            mock_auditor.stubs(:repositories).returns([])

            # Expect Auditor to be initialized with fix=true
            Auditor.expects(:new).with('test_token', 'test_org', true).returns(mock_auditor)

            # Run generator with fix=true
            generator = generator_class.new([], { fix: true }, {})
            generator.instance_variable_set(:@github_token, 'test_token')
            generator.instance_variable_set(:@github_organisation, 'test_org')
            generator.prep_audit
          end

          test 'filter_all_if_specified filters repositories when all is false' do
            # Mock the auditor
            mock_repo1 = stub(name: 'test_repo', archived?: false)
            mock_repo2 = stub(name: 'other_repo', archived?: false)
            mock_auditor = mock
            mock_auditor.stubs(:repositories).returns([mock_repo1, mock_repo2])

            Auditor.stubs(:new).returns(mock_auditor)

            # Run generator with all=false (default)
            generator = generator_class.new([], {}, {})
            generator.instance_variable_set(:@github_token, 'test_token')
            generator.instance_variable_set(:@github_organisation, 'test_org')
            # Stub the github_organisation_remotes method to return test_repo
            generator.stubs(:github_organisation_remotes).returns(['test_repo'])
            generator.prep_audit
            generator.filter_all_if_specified

            repositories = generator.instance_variable_get(:@repositories)
            # Should only include test_repo (from git remotes)
            assert_equal 1, repositories.length
            assert_equal 'test_repo', repositories.first.name
          end

          test 'filter_all_if_specified does not filter repositories when all is true' do
            # Mock the auditor
            mock_repo1 = stub(name: 'test_repo', archived?: false)
            mock_repo2 = stub(name: 'other_repo', archived?: false)
            mock_auditor = mock
            mock_auditor.stubs(:repositories).returns([mock_repo1, mock_repo2])

            Auditor.stubs(:new).returns(mock_auditor)

            # Run generator with all=true
            generator = generator_class.new([], { all: true }, {})
            generator.instance_variable_set(:@github_token, 'test_token')
            generator.instance_variable_set(:@github_organisation, 'test_org')
            generator.prep_audit
            generator.filter_all_if_specified

            repositories = generator.instance_variable_get(:@repositories)
            # Should include all repos
            assert_equal 2, repositories.length
          end

          test 'filter_by_topic_if_specified filters repositories by topic when topic is specified' do
            # Mock the auditor
            mock_repo1 = stub(name: 'test_repo', archived?: false, topics: %w[way-of-working ruby])
            mock_repo2 = stub(name: 'other_repo', archived?: false, topics: ['python'])
            mock_repo3 = stub(name: 'third_repo', archived?: false, topics: ['way-of-working'])
            mock_auditor = mock
            mock_auditor.stubs(:repositories).returns([mock_repo1, mock_repo2, mock_repo3])

            Auditor.stubs(:new).returns(mock_auditor)

            # Run generator with topic filter
            generator = generator_class.new([], { all: true, topic: 'way-of-working' }, {})
            generator.instance_variable_set(:@github_token, 'test_token')
            generator.instance_variable_set(:@github_organisation, 'test_org')
            generator.prep_audit
            generator.filter_by_topic_if_specified

            repositories = generator.instance_variable_get(:@repositories)
            # Should only include repos with 'way-of-working' topic
            assert_equal 2, repositories.length
            assert_includes repositories.map(&:name), 'test_repo'
            assert_includes repositories.map(&:name), 'third_repo'
          end

          test 'filter_by_visibility_if_specified filters repositories to only public when public is true' do
            # Mock the auditor
            mock_repo1 = stub(name: 'public_repo', archived?: false, private?: false)
            mock_repo2 = stub(name: 'private_repo', archived?: false, private?: true)
            mock_repo3 = stub(name: 'another_public_repo', archived?: false, private?: false)
            mock_auditor = mock
            mock_auditor.stubs(:repositories).returns([mock_repo1, mock_repo2, mock_repo3])

            Auditor.stubs(:new).returns(mock_auditor)

            # Run generator with public filter
            generator = generator_class.new([], { all: true, public: true }, {})
            generator.instance_variable_set(:@github_token, 'test_token')
            generator.instance_variable_set(:@github_organisation, 'test_org')
            generator.prep_audit
            generator.filter_by_visibility_if_specified

            repositories = generator.instance_variable_get(:@repositories)
            # Should only include public repos
            assert_equal 2, repositories.length
            assert_includes repositories.map(&:name), 'public_repo'
            assert_includes repositories.map(&:name), 'another_public_repo'
          end

          test 'filter_by_name_array_if_specified filters repositories by name when name is specified' do
            # Mock the auditor
            mock_repo1 = stub(name: 'structured_store', archived?: false)
            mock_repo2 = stub(name: 'other_repo', archived?: false)
            mock_repo3 = stub(name: 'another_repo', archived?: false)
            mock_auditor = mock
            mock_auditor.stubs(:repositories).returns([mock_repo1, mock_repo2, mock_repo3])

            Auditor.stubs(:new).returns(mock_auditor)

            # Run generator with name filter
            generator = generator_class.new([], { all: true, name: ['structured_store'] }, {})
            generator.instance_variable_set(:@github_token, 'test_token')
            generator.instance_variable_set(:@github_organisation, 'test_org')
            generator.prep_audit
            generator.filter_by_name_array_if_specified

            repositories = generator.instance_variable_get(:@repositories)
            # Should only include structured_store
            assert_equal 1, repositories.length
            assert_equal 'structured_store', repositories.first.name
          end

          test 'filter_all_if_specified does not filter when name is specified without all' do
            # Mock the auditor
            mock_repo1 = stub(name: 'structured_store', archived?: false)
            mock_repo2 = stub(name: 'other_repo', archived?: false)
            mock_repo3 = stub(name: 'test_repo', archived?: false)
            mock_auditor = mock
            mock_auditor.stubs(:repositories).returns([mock_repo1, mock_repo2, mock_repo3])

            Auditor.stubs(:new).returns(mock_auditor)

            # Run generator with name filter only (no --all flag)
            generator = generator_class.new([], { name: ['structured_store'] }, {})
            generator.instance_variable_set(:@github_token, 'test_token')
            generator.instance_variable_set(:@github_organisation, 'test_org')
            # Stub the github_organisation_remotes method
            generator.stubs(:github_organisation_remotes).returns(['test_repo'])
            generator.prep_audit
            generator.filter_all_if_specified

            repositories = generator.instance_variable_get(:@repositories)
            # Should include all repos because --name implies --all
            assert_equal 3, repositories.length
          end

          test 'filter_by_name_array_if_specified filters repositories by multiple names when multiple names are specified' do
            # Mock the auditor
            mock_repo1 = stub(name: 'structured_store', archived?: false)
            mock_repo2 = stub(name: 'other_repo', archived?: false)
            mock_repo3 = stub(name: 'another_repo', archived?: false)
            mock_auditor = mock
            mock_auditor.stubs(:repositories).returns([mock_repo1, mock_repo2, mock_repo3])

            Auditor.stubs(:new).returns(mock_auditor)

            # Run generator with multiple name filters
            generator = generator_class.new([], { all: true, name: %w[structured_store another_repo] }, {})
            generator.instance_variable_set(:@github_token, 'test_token')
            generator.instance_variable_set(:@github_organisation, 'test_org')
            generator.prep_audit
            generator.filter_by_name_array_if_specified

            repositories = generator.instance_variable_get(:@repositories)
            # Should only include structured_store and another_repo
            assert_equal 2, repositories.length
            assert_includes repositories.map(&:name), 'structured_store'
            assert_includes repositories.map(&:name), 'another_repo'
          end

          test 'combines topic and public filters when both are specified' do
            # Mock the auditor
            mock_repo1 = stub(name: 'public_with_topic', archived?: false, private?: false, topics: ['way-of-working'])
            mock_repo2 = stub(name: 'private_with_topic', archived?: false, private?: true, topics: ['way-of-working'])
            mock_repo3 = stub(name: 'public_without_topic', archived?: false, private?: false, topics: ['other'])
            mock_repo4 = stub(name: 'private_without_topic', archived?: false, private?: true, topics: ['other'])
            mock_auditor = mock
            mock_auditor.stubs(:repositories).returns([mock_repo1, mock_repo2, mock_repo3, mock_repo4])

            Auditor.stubs(:new).returns(mock_auditor)

            # Run generator with both topic and public filters
            generator = generator_class.new([], { all: true, topic: 'way-of-working', public: true }, {})
            generator.instance_variable_set(:@github_token, 'test_token')
            generator.instance_variable_set(:@github_organisation, 'test_org')
            generator.prep_audit
            generator.filter_by_topic_if_specified
            generator.filter_by_visibility_if_specified

            repositories = generator.instance_variable_get(:@repositories)
            # Should only include public repos with 'way-of-working' topic
            assert_equal 1, repositories.length
            assert_equal 'public_with_topic', repositories.first.name
          end

          test 'combines name, topic and public filters when all are specified' do
            # Mock the auditor
            mock_repo1 = stub(name: 'structured_store', archived?: false, private?: false,
                              topics: ['way-of-working'])
            mock_repo2 = stub(name: 'other_store', archived?: false, private?: true, topics: ['way-of-working'])
            mock_repo3 = stub(name: 'structured_store', archived?: false, private?: false, topics: ['other'])
            mock_repo4 = stub(name: 'public_with_topic', archived?: false, private?: false,
                              topics: ['way-of-working'])
            mock_auditor = mock
            mock_auditor.stubs(:repositories).returns([mock_repo1, mock_repo2, mock_repo3, mock_repo4])

            Auditor.stubs(:new).returns(mock_auditor)

            # Run generator with name, topic and public filters
            generator = generator_class.new([], { all: true, name: ['structured_store'], topic: 'way-of-working',
                                                  public: true }, {})
            generator.instance_variable_set(:@github_token, 'test_token')
            generator.instance_variable_set(:@github_organisation, 'test_org')
            generator.prep_audit
            generator.filter_by_name_array_if_specified
            generator.filter_by_topic_if_specified
            generator.filter_by_visibility_if_specified

            repositories = generator.instance_variable_get(:@repositories)
            # Should only include public structured_store with 'way-of-working' topic
            assert_equal 1, repositories.length
            assert_equal 'structured_store', repositories.first.name
          end
        end
      end
    end
  end
end
