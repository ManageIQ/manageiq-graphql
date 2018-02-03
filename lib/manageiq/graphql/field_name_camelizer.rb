module ManageIQ
  module GraphQL
    class FieldNameCamelizer
      def instrument(_type, field)
        field.property = field.name.underscore.to_sym if field.resolve_proc.kind_of?(::GraphQL::Field::Resolve::NameResolve)
        field.name = field.name.camelize(:lower)

        field.arguments = Hash[
          field.arguments.map do |_name, argument|
            argument.as = argument.name.underscore
            argument.name = argument.name.camelize(:lower)
            [argument.name, argument]
          end
        ]

        field
      end
    end
  end
end
