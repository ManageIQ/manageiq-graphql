module ManageIQ
  module GraphQL
    module Types
      Vm = ::GraphQL::ObjectType.define do
        name 'Vm'
        description 'A Virtual Machine is a software implementation of a system that functions similar to a physical machine. Virtual machines utilize the hardware infrastructure of a physical host, or a set of physical hosts, to provide a scalable and on-demand method of system provisioning.'
        implements ::GraphQL::Relay::Node.interface
        interfaces [Taggable]

        global_id_field :id
        field :database_id,
              !types.ID,
              "The database ID of the virtual machine",
              :property           => :id,
              :deprecation_reason => "This field may not be included in the ManageIQ Hammer release. Use the global Relay ID ('id') instead."
        field :vendor, !types.String, "The virtual machine's vendor"
        field :name, !types.String, "The name of the virtual machine"
        field :location, !types.String, "The location of the virtual machine"
        field :created_on, DateTime, "The timestamp of when the virtual machine was created in the VMDB"
        field :updated_on, DateTime, "The timestamp of when the virtual machine was last updated in the VMDB"
        field :guid, types.ID, "The globally unique identifier of the virtual machine"
        field :uid_ems, types.ID, "The unique identifier of the virtual machine across all possible instances for the same provider type"
        field :boot_time, DateTime, "The timestamp of when the virtual machine was last powered on"
        field :power_state, types.String, "The power state of the virtual machine, normalized to one of: on; powering_up; powering_down; suspended; terminated; off"
        field :state_changed_on, DateTime, "The timestamp of when the virtual machine last changed power state"
        field :previous_state, types.String, "The last power state of the virtual machine before changing to its current one"
        field :last_perf_capture_on, DateTime, "The timestamp of when the last metrics collection occurred for this virtual machine"
        field :ems_ref, types.ID, "The unique identifier of the virtual machine frome the native provider"
        field :cloud, types.Boolean, "Returns true for cloud virtual machines, false for infrastructure virtual machines"
        field :raw_power_state, types.String, "The power state of the virtual machine, as described by the provider"

        connection :service, !Service.connection_type, "The service object associated with this virtual machine" do
          preload :direct_services

          resolve ->(object, _args, _ctx) {
            object.service
          }
        end
      end
    end
  end
end
