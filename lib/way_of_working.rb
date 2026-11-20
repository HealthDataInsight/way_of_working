# frozen_string_literal: true

require 'way_of_working/cli'
require 'way_of_working/paths'
require 'zeitwerk'

# Require "internal" plugin(s) here
require 'way_of_working/readme_badge'

loader = Zeitwerk::Loader.for_gem
# tasks.rb is a rake-task entrypoint, not a constant definition — exclude it
# from Zeitwerk's file-to-constant expectations so downstream apps can
# `require 'way_of_working/tasks'` from their Rakefile.
loader.ignore(File.expand_path('way_of_working/tasks.rb', __dir__))
# github_audit_rule.rb files are loaded explicitly by their feature file (see
# readme_badge.rb) and register themselves on load, so keep them out of
# Zeitwerk's eager-load walk. Eager-loading them would register every rule,
# not just those of the features the user required.
loader.ignore("#{__dir__}/way_of_working/**/github_audit_rule.rb")
# Opt-in built-in feature entrypoints reopen the sub commands and register
# their generators at load time. Exclude them from Zeitwerk so eager loading
# (e.g. a Rails app in production) does not enable features the host never
# required. They are only loaded by an explicit `require`.
%w[
  audit/github
  changelog/keepachangelog
  code_of_conduct/contributor_covenant
  decision_record/madr
  inclusive_language/alex
  pull_request_template/hdi
  versioning/semver
].each { |feature| loader.ignore(File.expand_path("way_of_working/#{feature}.rb", __dir__)) }
loader.setup

# This is the namespace for everything associated with the Way of Working
module WayOfWorking
  class Error < StandardError; end
end

# Automatically load way_of_working plugins.
Gem::Specification.
  select { |gemspec| gemspec.name =~ /\Away_of_working-/ }.
  collect(&:name).uniq. # multiple versions of a single gem may be installed at once
  each do |name|
  require "#{name.gsub('-', '/')}/plugin"
end
