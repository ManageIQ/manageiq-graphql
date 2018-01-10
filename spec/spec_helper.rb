# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

require "manageiq/graphql/schema"

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

  Kernel.srand config.seed

  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
