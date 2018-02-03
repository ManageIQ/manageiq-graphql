module ManageIQ
  module GraphQL
    module Types
      QueueResultPayload = ::GraphQL::InterfaceType.define do
        name 'QueueResultPayload'
        description "An interface type for queue-related payloads. All mutations which delegate to ManageIQ's queue return a payload which implement this inteface."

        field :success, !types.Boolean
        field :message, types.String
        field :task_id, types.ID
      end
    end
  end
end
