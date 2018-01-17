#
# General RSpec configuration
# For Rails or ManageIQ-specific configuration, see manageiq_helper.rb
# This file is automatically required for all specs
#

if ENV['CI']
  require 'simplecov'
  SimpleCov.start
end

ENV['RAILS_ENV'] ||= 'test'

RSpec.configure do |config|
end

Dir["./spec/support/**/*.rb"].each { |f| require f }

require 'manageiq-graphql'
