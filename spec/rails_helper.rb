# Load the ManageIQ environment
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../manageiq/config/environment", __FILE__)

require "manageiq/graphql"
require 'rspec/rails'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.expose_dsl_globally = true

  config.include ManageIQ::GraphQL::Engine.routes.url_helpers, :type => :routing

  config.include_context "integration test setup", :type => :request
end

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
