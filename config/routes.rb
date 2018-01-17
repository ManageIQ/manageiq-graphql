ManageIQ::GraphQL::Engine.routes.draw do
  root :to => 'graphql#execute', :as => :endpoint, via: :post
end

Rails.application.routes.draw do
  mount ManageIQ::GraphQL::Engine, :at => '/graphql'

  if Rails.env.development?
    require 'graphiql/rails'
    mount GraphiQL::Rails::Engine, at: "/graphql/explorer", graphql_path: "/graphql"
  end
end
