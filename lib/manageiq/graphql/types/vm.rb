module ManageIQ::GraphQL::Types
  Vm = ::GraphQL::ObjectType.define do
    name 'Vm'
    description "Look, it's a virtual machine!"

    field :id, !types.ID
    field :vendor, !types.String
    field :name, !types.String
    field :location, !types.String
    field :created_at, !types.String
    field :updated_at, !types.String
    field :guid, !types.ID
    field :uid_ems, !types.ID
    field :boot_time, !types.String
    field :power_state, !types.String
    field :state_changed_on, !types.String
    field :previous_state, !types.String
    field :last_perf_capture_on, !types.String
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
