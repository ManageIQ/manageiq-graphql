require 'manageiq/graphql/types/taggable'

module ManageIQ
  module GraphQL
    module Types
      Service = ::GraphQL::ObjectType.define do
        name 'Service'
        description 'A Service is an item in a Service Catalog that can be requested.'
        interfaces [Taggable]

        field :id, !types.ID, "The ID of the service"
        field :name, !types.String, "The name of the service"
        field :description, !types.String, "A human-readable description of the service"
        field :guid, !types.ID, "The globally unique identifier of the service"
        field :type, !types.String, "The service type"
        field :display, !types.Boolean, "A true/false value determining if the service should be displayed"
        field :retired, !types.Boolean, "A true/false value as to whether the service is retired or not"
        field :retires_on, !DateTime, "A string representation of the date this service is to be retired"
        field :vms, types[Vm], "The virtual machines associated with this service" do
          resolve ->(object, args, ctx) {
            object.vms
          }
        end
      end
    end
  end
end
