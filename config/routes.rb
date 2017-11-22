Rails.application.routes.draw do
  namespace :graphql do
    root :to => 'application#execute', :as => :endpoint
  end

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, :at => '/graphql/explorer', :graphql_path => '/graphql'
  end
end
