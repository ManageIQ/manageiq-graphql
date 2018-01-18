module ManageIQ
  module GraphQL
    module Types
      DateTime = ::GraphQL::ScalarType.define do
        name "DateTime"
        description "An ISO-8601 encoded UTC date string."

        coerce_input ->(value, _ctx) { Time.zone.parse(value) }
        coerce_result ->(value, _ctx) { value.utc.iso8601 }
      end
    end
  end
end
