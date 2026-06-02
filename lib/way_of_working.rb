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
# github_audit_rule.rb is loaded conditionally (only when the
# way_of_working-audit-github plugin is present — see readme_badge.rb) and
# requires a constant from that plugin at the top of the file. Exclude it
# from Zeitwerk's eager-load walk so its absence doesn't break the loader.
loader.ignore(File.expand_path('way_of_working/changelog/keepachangelog/github_audit_rule.rb', __dir__))
loader.ignore(File.expand_path('way_of_working/decision_record/madr/github_audit_rule.rb', __dir__))
loader.ignore(File.expand_path('way_of_working/inclusive_language/alex/github_audit_rule.rb', __dir__))
loader.ignore(File.expand_path('way_of_working/readme_badge/github_audit_rule.rb', __dir__))
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
