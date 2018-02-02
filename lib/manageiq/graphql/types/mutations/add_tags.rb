module ManageIQ
  module GraphQL
    module Types
      module Mutations
        AddTags = ::GraphQL::Relay::Mutation.define do
          name 'AddTags'

          input_field :taggableId, !types.ID
          input_field :tagNames, !types[types.String]

          return_field :taggable, Taggable

          resolve ->(_object, args, ctx) {
            taggable = Schema.object_from_id(args['taggableId'], ctx)
            taggable.tag_add(args[:tagNames])
            taggable.reload

            { :taggable => taggable }
          }
        end
      end
    end
  end
end
