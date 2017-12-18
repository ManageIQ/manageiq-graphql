module ManageIQ
  module GraphQL
    module Types
      User = ::GraphQL::ObjectType.define do
        name 'User'
        description 'In Identity Service, each user is associated with one or more tenants, and in Compute can be associated with roles, projects, or both.'

        field :id, !types.ID
        field :name, !types.String
        field :email, !types.String
      end
    end
  end
end
