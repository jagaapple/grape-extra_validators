# frozen_string_literal: true

# Configures SimpleCov to get coverage and CodeCov.
# !! These should be written at the beginning of this file to work. !!
require "simplecov"
require "simplecov-console"
require "codecov"
if ENV["CODECOV_TOKEN"]
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
else
  SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter]
  SimpleCov.formatters << SimpleCov::Formatter::Console if ENV["COVERAGE"]
end
SimpleCov.start

# Loads core files.
require "bundler/setup"
require "rack/test"
require "grape/extra_validators"

# ------------------------------------------------------------------------------------------------------------------------------
# RSpec Settings
# ------------------------------------------------------------------------------------------------------------------------------
RSpec.configure do |config|
  config.include Rack::Test::Methods
end
