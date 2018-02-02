module ManageIQ
  module GraphQL
    module Types
      module Mutations
        PerformVmPowerOperation = ::GraphQL::Relay::Mutation.define do
          name 'PerformVmPowerOperation'
          description "Perform power operations on Virtual Machines"

          input_field :vmId, !types.ID
          input_field :operation, !VmPowerOperation

          return_interfaces [QueueResultPayload]

          resolve ->(_object, args, ctx) {
            begin
              vm = Schema.object_from_id(args[:vmId], ctx)
              vm = ::Rbac.filtered_object(vm)
              description = "Performing #{args[:operation]} operation on VM id: #{vm.id}, name: '#{vm.name}'"

              task_id = QueueService.enqueue(
                vm,
                description,
                :method_name => args[:operation],
                :role        => "ems_operations"
              )

              { :success => true, :message => description, :taskId => task_id }
            rescue StandardError => error
              { :success => false, :message => error.to_s }
            end
          }
        end
      end
    end
  end
end
