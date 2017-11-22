ManageIQ::GraphQL::Engine.routes.draw do
  root :to => 'application#execute', :as => :endpoint

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, :at => '/explorer', :graphql_path => '/graphql'
  end
end
