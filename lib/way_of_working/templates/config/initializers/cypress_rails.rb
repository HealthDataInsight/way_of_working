return unless Rails.env.test?

Rails.application.load_tasks unless defined?(Rake::Task)

CypressRails.hooks.before_server_start do
  # Called once, before either the transaction or the server is started
  # Add our fixtures before the resettable transaction is started
  # Rake::Task["db:fixtures:load"].invoke
end

CypressRails.hooks.after_server_start do
  # Called after the server is started
end

CypressRails.hooks.after_transaction_start do
  # Called after the transaction is started (at launch and after each reset)
end

CypressRails.hooks.after_state_reset do
  # Triggered after `/cypress_rails_reset_state` is called
end

CypressRails.hooks.before_server_stop do
  # Called once, at_exit
  # Purge and reload the test database so we don't leave our fixtures in there
  # Rake::Task["db:test:prepare"].invoke
end
