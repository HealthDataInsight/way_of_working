# frozen_string_literal: true

require 'ndr_dev_support/tasks'
require 'rubocop/rake_task'

RuboCop::RakeTask.new

load 'tasks/audit_gems.rake'
load 'tasks/clean_brew.rake'
