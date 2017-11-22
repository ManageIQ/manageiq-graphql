require 'manageiq/graphql/types/query'

module ManageIQ::GraphQL
  Schema = ::GraphQL::Schema.define do
    raise_definition_error true

    query Types::Query
  end
end
