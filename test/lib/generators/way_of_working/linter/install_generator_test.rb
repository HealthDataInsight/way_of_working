require "test_helper"
require "generators/way_of_working/linter/install/install_generator"

class WayOfWorking::Linter::InstallGeneratorTest < Rails::Generators::TestCase
  tests WayOfWorking::Linter::InstallGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  test 'generator runs without errors' do
    assert_nothing_raised do
      run_generator
    end
  end

  test 'files are created and revoked' do
    run_generator

    assert_file '.github/linters/.keep'
    assert_file '.github/workflows/mega-linter.yml'
    assert_file '.mega-linter.yml'

    assert_file '.gitignore' do |content|
      assert_match("megalinter-reports/\n", content)
      # TODO: Add assert_match(".rubocop-https---raw-githubusercontent-com-NHSDigital-ndr-dev-support-v6-1-9-config-rubocop-ndr-yml\n", content)
    end

    run_generator [], behavior: :revoke

    assert_no_file '.github/linters/.keep'
    assert_no_file '.github/workflows/mega-linter.yml'
    assert_no_file '.mega-linter.yml'

    assert_file '.gitignore' do |content|
      refute_match("megalinter-reports/\n", content)
      # TODO: Add refute_match(".rubocop-https---raw-githubusercontent-com-NHSDigital-ndr-dev-support-v6-1-9-config-rubocop-ndr-yml\n", content)
    end
  end
end
