Pathname.glob(Pathname(__FILE__).dirname.join("types/**/*.rb")).each do |file|
  require_dependency file
end

module ManageIQ
  module GraphQL
    Schema = ::GraphQL::Schema.define do
      use ::GraphQL::Batch

      raise_definition_error true
      enable_preloading

      instrument(:field, FieldNameCamelizer.new)

      query Types::Query
      mutation Types::Mutation

      resolve_type ->(_abstract_type, obj, _ctx) {
        # TODO: This resolver is incredibly naive and should be refactored.
        case obj.class.name
        when /Vm/
          Types::Vm
        when /Service/
          Types::Service
        when /Host/
          Types::Host
        end
      }

      id_from_object ->(object, type_definition, _query_ctx) {
        # Create UUIDs by joining the type name & ID, then base64-encoding it
        ::GraphQL::Schema::UniqueWithinType.encode(type_definition.name, object.id)
      }

      object_from_id ->(id, _query_ctx) {
        type_name, item_id = ::GraphQL::Schema::UniqueWithinType.decode(id)
        # TODO: This resolver is incredibly naive and should be refactored.
        model_klass = case type_name
                      when /Vm/
                        ::Vm
                      when /Service/
                        ::Service
                      when /Host/
                        ::Host
                      end
        model_klass.find(item_id)
      }
    end
  end
end
