module ManageIQ
  module GraphQL
    module Types
      Service = ::GraphQL::ObjectType.define do
        name 'Service'
        description 'A Service is an item in a Service Catalog that can be requested.'
        implements ::GraphQL::Relay::Node.interface
        interfaces [Taggable]

        global_id_field :id
        field :database_id,
              !types.ID,
              "The database ID of the service",
              :property           => :id,
              :deprecation_reason => "This field may not be included in the ManageIQ Hammer release. Use the global Relay ID ('id') instead."
        field :name, !types.String, "The name of the service"
        field :description, types.String, "A human-readable description of the service"
        field :guid, types.ID, "The globally unique identifier of the service"
        field :display, !types.Boolean, "A true/false value determining if the service should be displayed"
        field :retired, !types.Boolean, "A true/false value as to whether the service is retired or not"
        field :retires_on, DateTime, "A string representation of the date this service is to be retired"

        connection :vms, !Vm.connection_type, "The virtual machines associated with this service"
      end
    end
  end
end
