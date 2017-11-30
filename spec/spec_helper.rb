# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

ENV['RAILS_ENV'] ||= 'test'

# Load the ManageIQ environment
require File.expand_path("../manageiq/config/environment", __FILE__)

require 'rspec/rails'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.default_formatter = "doc" if config.files_to_run.one?
  config.order = :random

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  Kernel.srand config.seed

  config.use_transactional_fixtures = true

  config.include ManageIQ::GraphQL::Engine.routes.url_helpers, :type => :routing

  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end

# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

