module ManageIQ
  module GraphQL
    module Types
      Taggable = ::GraphQL::InterfaceType.define do
        name "Taggable"
        field :tags, types[Tag], "A list of tags assigned with this taggable" do
          preload :tags

          resolve ->(object, args, ctx) {
            object.tags
          }
        end
      end
    end
  end
end
