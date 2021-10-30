# frozen_string_literal: true

require "rubygems"
require "bundler/setup"
Bundler.require
require "pondus"
require "simplecov"
require "active_record"

SimpleCov.start "rails" do
end

SimpleCov.minimum_coverage 100

$LOAD_PATH.unshift File.expand_path("support", __dir__)
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.include SQLHelpers

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
