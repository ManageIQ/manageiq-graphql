module ManageIQ
  module GraphQL
    module Types
      QueueResultPayload = ::GraphQL::InterfaceType.define do
        name 'QueueResultPayload'

        field :success, !types.Boolean
        field :message, types.String
        field :taskId, types.ID
      end
    end
  end
end
