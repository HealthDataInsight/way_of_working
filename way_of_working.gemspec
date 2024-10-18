# frozen_string_literal: true

require_relative 'lib/way_of_working/version'

Gem::Specification.new do |spec|
  spec.name = 'way_of_working'
  spec.version = WayOfWorking::VERSION
  spec.authors = ['Tim Gentry']
  spec.email = ['52189+timgentry@users.noreply.github.com']

  spec.summary = 'RubyGem for the HDI way of working.'
  # spec.description = "TODO: Write a longer description or delete this line."
  spec.homepage = 'https://healthdatainsight.github.io/way_of_working'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/HealthDataInsight/way_of_working'
  spec.metadata['changelog_uri'] = 'https://github.com/HealthDataInsight/way_of_working/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").select do |f|
      f.match(%r{\A(?:(?:exe|lib)/|[^/]+\.(?:gemspec|md|tt|txt))})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.add_dependency 'activesupport'
  spec.add_dependency 'git', '~> 1.13'
  spec.add_dependency 'nokogiri'
  spec.add_dependency 'rainbow', '~> 3.1'
  spec.add_dependency 'thor', '~> 1.2'
  spec.add_dependency 'zeitwerk', '~> 2.6.18'
end
