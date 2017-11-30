require 'manageiq/graphql/types/query'

module ManageIQ
  module GraphQL
    Schema = ::GraphQL::Schema.define do
      use ::GraphQL::Batch

      raise_definition_error true
      enable_preloading

      query Types::Query
    end
  end
end
