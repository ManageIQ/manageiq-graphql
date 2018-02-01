module ManageIQ
  module GraphQL
    module Types
      Mutation = ::GraphQL::ObjectType.define do
        name 'Mutation'
        description 'The root type for a mutation operation; a write followed by fetch.'

        field :addTags, :field => Mutations::AddTags.field

        field :removeTags, Taggable do
          description "Remove tags from a Taggable"
          argument :taggableId, !types.ID
          argument :taggableType, !types.String
          argument :tagNames, !types[types.String]

          resolve ->(_object, args, _ctx) {
            # WARNING: This isn't actually safe, it's merely for PoC
            klass = "::#{args[:taggableType]}".constantize
            taggable = klass.find(args[:taggableId])
            taggable.tag_remove(args[:tagNames])
            taggable.reload
          }
        end

        # TODO: This is very PoC
        field :performVmPowerOperation, ActionResultPayload do
          name 'performVmPowerOperation'
          description "Perform power operations on Virtual Machines"
          argument :vm_id, !types.ID
          argument :operation, VmPowerOperation

          resolve ->(_object, args, _ctx) {
            begin
              vm = ::Vm.find(args[:vm_id])
              vm = ::Rbac.filtered_object(vm)
              description = "Performing #{args[:operation]} operation on VM id: #{vm.id}, name: '#{vm.name}'"

              task_id = QueueService.enqueue(
                vm,
                description,
                :method_name => args[:operation],
                :role        => "ems_operations"
              )

              # TODO: ActionResultPayloads probably won't be a thing anyway, but even if they were to be
              # this should be a proper object mapping to that type, not just OpenStruct....maybe.
              # TODO: We shouldn't be rescuing all errors like we do in the REST API.
              # We should be explicitly defining exceptional behavior from core and returning that, but
              # properly raising our own faults.
              OpenStruct.new(:success => true, :message => description, :task_id => task_id)
            rescue StandardError => error
              OpenStruct.new(:success => false, :message => error.to_s)
            end
          }
        end
      end
    end
  end
end
