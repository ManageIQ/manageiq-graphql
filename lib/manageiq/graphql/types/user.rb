module ManageIQ
  module GraphQL
    module Types
      User = ::GraphQL::ObjectType.define do
        name 'User'
        description 'In Identity Service, each user is associated with one or more tenants, and in Compute can be associated with roles, projects, or both.'
        implements ::GraphQL::Relay::Node.interface

        global_id_field :id
        field :database_id,
              !types.ID,
              "The database ID of the user",
              :property           => :id,
              :deprecation_reason => "This field may not be included in the ManageIQ Hammer release. Use the global Relay ID ('id') instead."
        field :name, !types.String
        field :email, !types.String
      end
    end
  end
end
