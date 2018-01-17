ManageIQ::GraphQL::Engine.routes.draw do
  root :to => 'graphql#execute', :as => :endpoint, via: :post
end

Rails.application.routes.draw do
  mount ManageIQ::GraphQL::Engine, :at => '/graphql'
end
