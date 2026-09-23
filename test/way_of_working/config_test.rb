# frozen_string_literal: true

require 'test_helper'
require 'tmpdir'
require 'yaml'

module WayOfWorking
  # This class tests WayOfWorking::Config
  class ConfigTest < ActiveSupport::TestCase
    setup do
      @config_path = Pathname.new(Dir.mktmpdir).join('config.yaml')
      Config.stubs(:path).returns(@config_path)
    end

    test 'get returns nil when nothing is stored, without creating a file' do
      assert_nil Config.get('code_of_conduct.contact_method')
      refute @config_path.exist?
    end

    test 'set then get round-trips a nested dotted key' do
      Config.set('code_of_conduct.contact_method', 'foo@bar.com')

      assert_equal 'foo@bar.com', Config.get('code_of_conduct.contact_method')
      assert_equal({ 'code_of_conduct' => { 'contact_method' => 'foo@bar.com' } }, YAML.load_file(@config_path))
    end

    test 'set preserves sibling keys already on disk' do
      Config.set('code_of_conduct.contact_method', 'foo@bar.com')
      Config.set('security.contact_method', 'security@bar.com')

      assert_equal 'foo@bar.com', Config.get('code_of_conduct.contact_method')
      assert_equal 'security@bar.com', Config.get('security.contact_method')
    end

    test 'get returns nil for a key nested under a non-hash value' do
      Config.set('code_of_conduct.contact_method', 'foo@bar.com')

      assert_nil Config.get('code_of_conduct.contact_method.oops')
    end
  end
end
