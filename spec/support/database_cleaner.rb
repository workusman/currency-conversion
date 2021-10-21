# frozen_string_literal: true

DatabaseCleaner.strategy = :transaction

RSpec.configure do |config|
  config.before :suite do
    DatabaseCleaner.clean_with :truncation
  end
  config.before :each do
    DatabaseCleaner.start
  end
  config.after :each do
    DatabaseCleaner.clean
  end
  config.after :suite do
    DatabaseCleaner.clean_with :truncation
  end
end
