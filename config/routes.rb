ManageIQ::GraphQL::Engine.routes.draw do
  root :to => 'application#execute', :as => :endpoint
end
