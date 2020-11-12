#
# ManageIQ and Rails configuration
# For general RSpec configuration, see spec_helper.rb
# Require this file in every spec file that requires ManageIQ to run
#

# Load the ManageIQ environment
require File.expand_path("../manageiq/config/environment", __FILE__)

# Configure rspec-rails
require 'rspec/rails'
require 'rspec/mocks'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.expose_dsl_globally = true

  config.include ManageIQ::GraphQL::Engine.routes.url_helpers, :type => :routing
  config.include IntegrationMacros, :type => :request
end

# Load test helpers from ManageIQ
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
