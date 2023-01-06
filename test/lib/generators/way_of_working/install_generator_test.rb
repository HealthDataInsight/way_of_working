require "test_helper"
require "generators/way_of_working/install/install_generator"

class WayOfWorking::InstallGeneratorTest < Rails::Generators::TestCase
  tests WayOfWorking::InstallGenerator
  destination Rails.root.join("tmp/generators")
  # setup :prepare_destination

  setup do
    prepare_destination

    # We also want a vanilla Rakefile in the destination folder
    FileUtils.copy Rails.root.join('test/resources/vanilla_rails_Rakefile'),
                   destination_root.join('Rakefile')
  end

  test "generator runs without errors" do
    assert_nothing_raised do
      run_generator
    end
  end

  test 'Rakefile is amended and revoked' do
    assert_file 'Rakefile' do |content|
      refute_match("require 'way_of_working/tasks' if Rails.env.development? || Rails.env.test?\n", content)
    end

    run_generator

    assert_file 'Rakefile' do |content|
      assert_match("require 'way_of_working/tasks' if Rails.env.development? || Rails.env.test?\n", content)
    end

    run_generator [], behavior: :revoke

    assert_file 'Rakefile' do |content|
      refute_match("require 'way_of_working/tasks' if Rails.env.development? || Rails.env.test?\n", content)
    end
  end
end
