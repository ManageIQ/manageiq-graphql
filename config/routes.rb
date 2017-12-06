ManageIQ::GraphQL::Engine.routes.draw do
  root :to => 'graphql#execute', :as => :endpoint, via: :post
  get "/queries", :to => "graphql#queries"
end
