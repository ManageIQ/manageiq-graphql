module ManageIQ
  module GraphQL
    module Types
      Mutation = ::GraphQL::ObjectType.define do
        name 'Mutation'
        description 'The root type for a mutation operation; a write followed by fetch.'

        field :addTags, :field => Mutations::AddTags.field
        field :removeTags, :field => Mutations::RemoveTags.field
        field :performVmPowerOperation, :field => Mutations::PerformVmPowerOperation.field
      end
    end
  end
end
