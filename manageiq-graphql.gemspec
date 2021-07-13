$:.push(File.expand_path("../lib", __FILE__))

# Maintain your gem's version:
require "manageiq/graphql/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "manageiq-graphql"
  s.version     = ManageIQ::GraphQL::VERSION
  s.authors     = ["ManageIQ Authors"]
  s.homepage    = "https://github.com/ManageIQ/manageiq-graphql"
  s.summary     = "The GraphQL API for ManageIQ"
  s.description = "This project includes the Rails engine powering the GraphQL API for ManageIQ - https://github.com/ManageIQ/manageiq"
  s.license     = "Apache-2.0"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE.txt", "Rakefile", "README.md"]

  s.add_runtime_dependency("graphql", "~> 1.7", "< 1.10.6")
  s.add_runtime_dependency("graphql-batch", "~> 0.4.3")
  s.add_runtime_dependency("graphql-preload", "=2.1.0.1")

  s.add_development_dependency("codeclimate-test-reporter", "~> 1.0.0")
  s.add_development_dependency("manageiq-style")
  s.add_development_dependency("simplecov")
  s.add_development_dependency("spring")
  s.add_development_dependency("spring-commands-rspec")
end
