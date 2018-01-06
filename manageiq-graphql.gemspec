$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "manageiq/graphql/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "manageiq-graphql"
  s.version     = ManageIQ::GraphQL::VERSION
  s.authors     = ["Chris Arcand"]
  s.email       = ["chris@chrisarcand.com"]
  s.homepage    = "https://github.com/manageiq/manageiq-graphql"
  s.summary     = "The GraphQL API for ManageIQ"
  s.description = "This project includes the Rails engine powering the GraphQL V2 API for ManageIQ - https://github.com/manageiq/manageiq"
  s.license     = "Apache-2.0"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE.txt", "Rakefile", "README.md"]

  s.add_runtime_dependency "graphql", "~> 1.7"
  s.add_runtime_dependency "graphql-batch", "~> 0.3.8"
  s.add_runtime_dependency "graphql-preload", "~> 1.0"
  s.add_runtime_dependency "rails", ">= 5.0", "< 5.1" # (In lieu of depending on ManageIQ core directly)

  s.add_development_dependency "rspec-rails", "~> 3.7"
end
