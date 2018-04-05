module ManageIQ
  module GraphQL
    module Types
      Provider = ::GraphQL::ObjectType.define do
        name "Provider"
        description "A provider is a server with software to manage multiple virtual machines that reside on multiple hosts"
        interfaces [Taggable]

        global_id_field :id
        field :database_id,
              !types.ID,
              "The database ID of the provider",
              :property           => :id,
              :deprecation_reason => "This field may not be included in the ManageIQ Hammer release. Use the global Relay ID ('id') instead."
        field :api_version, types.String
        field :created_on, !DateTime
        field :enabled, types.Boolean
        field :guid, types.ID
        field :last_refresh_date, DateTime
        field :name, !types.String, "The name of the provider"
        field :uid_ems, types.String
        field :updated_on, !DateTime

        connection :hosts, !Host.connection_type, "The hosts associated with this provider" do
          preload :hosts
        end
      end
    end
  end
end
