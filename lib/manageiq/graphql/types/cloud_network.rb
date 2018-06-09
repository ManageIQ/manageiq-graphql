module ManageIQ
  module GraphQL
    module Types
      CloudNetwork = ::GraphQL::ObjectType.define do
        name "CloudNetwork"
        description "A Cloud Network is a virtual Layer 3 network for cloud"
        interfaces [Taggable]

        global_id_field :id
        field :database_id,
              !types.ID,
              "The database ID of the network",
              :property           => :id,
              :deprecation_reason => "This field may not be included in the ManageIQ Hammer release. Use the global Relay ID ('id') instead."
        field :cidr, types.String
        field :ems_ref, types.ID, "Provider's unique identifier of a cloud network"
        field :enabled, types.Boolean
        field :external_facing, types.Boolean
        field :extra_attributes, types.String
        field :name, types.String, "The name of the network"
        field :provider_network_type, types.String
        field :provider_physical_network, types.String
        field :provider_segmentation_id, types.String
        field :shared, types.Boolean
        field :status, types.String
        field :vlan_transparent, types.Boolean
      end
    end
  end
end
