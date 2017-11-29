module ManageIQ
  module GraphQL
    module Types
      Vm = ::GraphQL::ObjectType.define do
        name 'Vm'
        description 'A software implementation of a system that functions similar to a physical machine. Virtual machines utilize the hardware infrastructure of a physical host, or a set of physical hosts, to provide a scalable and on-demand method of system provisioning.'

        field :id, !types.ID, "The ID of the virtual machine"
        field :vendor, !types.String, "The virtual machine's vendor"
        field :name, !types.String, "The name of the virtual machine"
        field :location, !types.String, "The location of the virtual machine"
        field :created_at, !types.String
        field :updated_at, !types.String
        field :guid, !types.ID, "The globally unique identifier of the virtual machine"
        field :uid_ems, !types.ID
        field :boot_time, !types.String
        field :power_state, !types.String
        field :state_changed_on, !types.String
        field :previous_state, !types.String
        field :last_perf_capture_on, !types.String, "The timestamp of when the last metrics collection occurred for this virtual machine"
        field :template, !types.Boolean
        field :miq_group_id, !types.ID
        field :type, !types.String
        field :ems_ref, !types.ID
        field :flavor_id, !types.ID
        field :cloud, !types.Boolean
        field :raw_power_state, !types.String
        field :tenant_id, !types.ID
        # field :actions, !types.?
      end
    end
  end
end
