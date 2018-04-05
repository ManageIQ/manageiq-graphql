module ManageIQ
  module GraphQL
    module Types
      Host = ::GraphQL::ObjectType.define do
        name "Host"
        description "A computer on which virtual machine monitor software is loaded."
        interfaces [Taggable]

        global_id_field :id
        field :database_id,
              !types.ID,
              "The database ID of the host",
              :property           => :id,
              :deprecation_reason => "This field may not be included in the ManageIQ Hammer release. Use the global Relay ID ('id') instead."
        field :name, !types.String, "The name of the host"
        field :hostname, types.String
        field :ipaddress, types.String
        field :vmm_vendor, types.String
        field :vmm_version, types.String
        field :vmm_product, types.String
        field :vmm_buildnumber, types.String
        field :created_on, !DateTime
        field :updated_on, !DateTime
        field :guid, types.ID
        field :user_assigned_os, types.String
        field :power_state, types.String
        field :smart, types.Int
        field :last_perf_capture_on, DateTime
        field :uid_ems, types.ID
        field :connection_state, types.String
        field :ssh_permit_root_login, types.String
        field :ems_ref_obj, types.String
        field :admin_disabled, types.Boolean
        field :service_tag, types.String
        field :asset_tag, types.String
        field :ipmi_address, types.String
        field :mac_address, types.String
        field :failover, types.Boolean
        field :ems_ref, types.ID
        field :hyperthreading, types.Boolean
        field :next_available_vnc_port, types.Int
        field :hypervisor_hostname, types.String
        field :maintenance, types.Boolean
        field :maintenance_reason, types.String

        connection :vms, !Vm.connection_type, "The virtual machines associated with this host" do
          preload :vms
        end
      end
    end
  end
end
