module ManageIQ
  module GraphQL
    module Types
      # TODO: This is basically just a simplied version of the current
      # action result response in the REST API. It should probably be
      # gone over and formalized a little better.
      # It probably can't be used with Relay anyway.
      ActionResultPayload = ::GraphQL::ObjectType.define do
        name 'ActionResultPayload'
        description "The result of an action taken on something"

        field :success, !types.Boolean
        field :message, types.String
        field :task_id, types.Int
      end
    end
  end
end
