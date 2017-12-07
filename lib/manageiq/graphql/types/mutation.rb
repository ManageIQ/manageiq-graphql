module ManageIQ
  module GraphQL
    module Types
      Mutation = ::GraphQL::ObjectType.define do
        name 'Mutation'

        # Note: These are incredibly naive ways of doing a mutation.
        # Mutations should be implemented with object identification conforming
        # to the Relay specification:
        # https://facebook.github.io/relay/graphql/objectidentification.htm
        field :addTags, Taggable do
          description "Adds tags to a Taggable"
          argument :taggableId, !types.ID
          argument :taggableType, !types.String
          argument :tagNames, !types[types.String]

          resolve ->(object, args, ctx) {
            # WARNING: This isn't actually safe, it's merely for PoC
            klass = "::#{args[:taggableType]}".constantize
            taggable = klass.find(args[:taggableId])
            taggable.tag_add(args[:tagNames])
            taggable.reload
          }
        end

        field :removeTags, Taggable do
          description "Remove tags from a Taggable"
          argument :taggableId, !types.ID
          argument :taggableType, !types.String
          argument :tagNames, !types[types.String]

          resolve ->(object, args, ctx) {
            # WARNING: This isn't actually safe, it's merely for PoC
            klass = "::#{args[:taggableType]}".constantize
            taggable = klass.find(args[:taggableId])
            taggable.tag_remove(args[:tagNames])
            taggable.reload
          }
        end
      end
    end
  end
end
