# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  enable_coverage :branch
  primary_coverage :branch

  # Everything the gem ships has to be covered, whether it was loaded or not.
  cover 'lib/**/*.rb'
  skip 'lib/plenty_client/version.rb'

  minimum_coverage line: 100, branch: 100
end

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'webmock/rspec'
require 'plenty_client'

Dir[File.expand_path('support/**/*.rb', __dir__)].sort.each { |file| require file }

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.order = :random

  config.include ConfigHelpers

  # PlentyClient::Config is global mutable state on the class object, so every
  # example starts from a known blank slate.
  config.around do |example|
    reset_config!
    example.run
    reset_config!
  end
end
